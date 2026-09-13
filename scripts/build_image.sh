#!/bin/bash
# Build a JustVerify Pi 5 image end to end: verified fetch, compile, real
# regtest integration tests, image assembly, checksum. This is the single
# source of truth for the build process -- docs/BUILD.md tells a human to
# run this script, and .github/workflows/build-image.yml runs the same
# script in CI. Do not fork the build steps into a second copy anywhere;
# change them here.
#
# Usage:
#   sudo bash scripts/build_image.sh <tag>
#
# Environment overrides (mainly for CI, which already has a checkout):
#   JV_REPO   Use this existing checkout instead of cloning a fresh one.
#   JV_WORK   Scratch directory for downloads/build outputs. Defaults to a
#             fresh mktemp directory.
set -euo pipefail

JV_TAG="${1:?usage: build_image.sh <tag>}"
[[ "$JV_TAG" =~ ^[A-Za-z0-9.-]+$ ]] || { echo "tag must match ^[A-Za-z0-9.-]+\$"; exit 1; }

SUDO=""
[[ $EUID -eq 0 ]] || SUDO="sudo"
run_as_justverify() {
  if [[ $EUID -eq 0 ]]; then su -s /bin/bash -c "$1" justverify
  else sudo -u justverify bash -c "$1"
  fi
}

test "$(uname -sm)" = "Linux aarch64"
test "$(. /etc/os-release; echo "$VERSION_ID")" = "13"
$SUDO -v || true

# A bind-mounted checkout (CI's JV_REPO) is owned by a different uid than
# whoever runs this script, which git's ownership check refuses by default.
git config --global --add safe.directory '*'

echo "== [1/6] apt packages =="
export DEBIAN_FRONTEND=noninteractive
$SUDO apt-get update
$SUDO apt-get install --no-install-recommends -y \
  git curl ca-certificates gnupg build-essential clang libclang-dev \
  cmake pkg-config libssl-dev python3 python3-venv xz-utils tar gzip patch \
  file jq parted fdisk e2fsprogs dosfstools zerofree util-linux udev kmod systemd \
  openssl npm nodejs=20.19.2+dfsg-1+deb13u2 \
  mariadb-server=1:11.8.6-0+deb13u1
python3 -c 'import sys; assert sys.version_info[:2] == (3, 13)'
$SUDO modprobe loop || true
$SUDO losetup --find

echo "== [2/6] source + toolchains =="
JV_WORK="${JV_WORK:-$(mktemp -d /var/tmp/justverify-source.XXXXXX)}"
chmod 755 "$JV_WORK"
if [[ -z "${JV_REPO:-}" ]]; then
  git clone --branch main --single-branch \
    https://github.com/dontrustjustverify/justverify.git "$JV_WORK/repo"
  JV_REPO="$JV_WORK/repo"
  cd "$JV_REPO"
  git switch --detach "$(git rev-parse HEAD)"
else
  cd "$JV_REPO"
fi
mkdir -p .state/build-guide docs/evidence
git rev-parse HEAD > .state/build-guide/source-commit.txt
curl --proto '=https' --tlsv1.2 -fsSLo "$JV_WORK/rustup-init.sh" https://sh.rustup.rs
sh "$JV_WORK/rustup-init.sh" -y --profile minimal --default-toolchain none
source "$HOME/.cargo/env"
rustup toolchain install 1.98.0 --profile minimal --component rustfmt --component clippy
rustup toolchain install 1.84.1 --profile minimal
rustc +1.98.0 --version
rustc +1.84.1 --version

echo "== [3/6] fetch verified inputs + compile =="
cd "$JV_REPO"
JV_BASE="$JV_WORK/raspios-lite-arm64.img.xz"
python3 - "$JV_BASE" <<'FETCH_BASE'
import hashlib, json, pathlib, shutil, sys, urllib.request
m = json.loads(pathlib.Path('catalog/pi-base.json').read_text())
p = pathlib.Path(sys.argv[1])
assert not p.exists(), 'use a fresh output path'
with urllib.request.urlopen(m['url'], timeout=120) as src, p.open('xb') as dst:
    shutil.copyfileobj(src, dst)
with p.open('rb') as f:
    assert hashlib.file_digest(f, 'sha256').hexdigest() == m['sha256']
print('PASS Pi OS compressed SHA256')
FETCH_BASE
python3 scripts/fetch_core.py 31.1 aarch64-linux-gnu
python3 scripts/fetch_core.py 22.0 aarch64-linux-gnu
JV_CORE="$JV_REPO/.cache/core/31.1/aarch64-linux-gnu/bitcoin-31.1"
export CARGO_BUILD_JOBS="${CARGO_BUILD_JOBS:-2}"
cargo +1.98.0 build --release --locked 2>&1 | tee .state/build-guide/cargo-build.log
cargo +1.98.0 test --locked 2>&1 | tee .state/build-guide/cargo-test.log
RUSTUP_TOOLCHAIN=1.98.0 python3 scripts/build_electrs.py "$JV_WORK/electrs" \
  2>&1 | tee .state/build-guide/electrs-build.log
JV_ELECTRS_COMMIT=$(jq -r .commit catalog/electrs.json)
JV_ELECTRS="$JV_WORK/electrs/electrs-$JV_ELECTRS_COMMIT/target/release/electrs"
RUSTUP_TOOLCHAIN=1.84.1 bash scripts/build_mempool.sh "$JV_WORK/mempool" \
  2>&1 | tee .state/build-guide/mempool-build.log
JV_MEMPOOL="$JV_WORK/mempool/bundle"
(cd "$JV_MEMPOOL" && sha256sum -c SHA256SUMS > /dev/null)

echo "== [4/6] real integration tests (regtest) =="
cd "$JV_REPO"
if getent passwd justverify >/dev/null || test -e /opt/justverify/venv; then
  echo 'Use a clean isolated builder: test account/runtime already exists.'
  exit 1
fi
$SUDO useradd --system --user-group --create-home \
  --home-dir /var/lib/justverify --shell /usr/sbin/nologin justverify
$SUDO install -d /opt/justverify
$SUDO python3 -m venv /opt/justverify/venv
$SUDO /opt/justverify/venv/bin/pip install --require-hashes --only-binary=:all: \
  -r "$JV_REPO/web/requirements.arm64.lock"
sha256sum "$JV_ELECTRS" > .state/build-guide/electrs-before-tests.sha256
for version in 31.1 22.0; do
  core="$JV_REPO/.cache/core/$version/aarch64-linux-gnu/bitcoin-$version"
  $SUDO install -d -o justverify -g justverify "$JV_WORK/tests-$version"
  state="$JV_WORK/tests-$version/jv-mempool-test-$version"
  run_as_justverify "/opt/justverify/venv/bin/python '$JV_REPO/tests/mempool_live.py' \
    --state '$state' --core '$core/bin' --electrs '$JV_ELECTRS' \
    --bundle '$JV_MEMPOOL' --version '$version'"
  $SUDO cat "$state/result.json" > ".state/build-guide/regtest-$version.json"
done
sha256sum -c .state/build-guide/electrs-before-tests.sha256

echo "== qualify newly compiled electrs =="
python3 - "$JV_ELECTRS" <<'LOCAL_EVIDENCE'
import hashlib, json, pathlib, sys
p = pathlib.Path('catalog/electrs.json')
m = json.loads(p.read_text())
with open(sys.argv[1], 'rb') as f:
    digest = hashlib.file_digest(f, 'sha256').hexdigest()
before = pathlib.Path('.state/build-guide/electrs-before-tests.sha256').read_text().split()[0]
build = json.loads(pathlib.Path(sys.argv[1]).parents[3].joinpath('build-result.json').read_text())
assert digest == before == build['binary_sha256']
assert build['source_sha256'] == m['source_sha256']
reports = {}
for version in ('31.1', '22.0'):
    r = json.loads(pathlib.Path(f'.state/build-guide/regtest-{version}.json').read_text())
    assert r['status'] == 'PASS' and r['confirmations'] == 2
    assert r['core_electrs_mempool_height'] == 107
    assert r['versions']['core'].startswith('/Satoshi:' + version + '.')
    reports[version] = r
evidence = {'previous_binary_sha256': m['tested_arm64_binary_sha256'],
            'local_binary_sha256': digest, 'build': build, 'regtest': reports,
            'hardware_boot': 'NOT RUN', 'whole_image_reproducibility': 'NOT RUN'}
pathlib.Path('.state/build-guide/local-electrs-validation.json').write_text(json.dumps(evidence, indent=2)+'\n')
if m['tested_arm64_binary_sha256'] != digest:
    m['tested_arm64_binary_sha256'] = digest
    p.write_text(json.dumps(m, indent=2)+'\n')
LOCAL_EVIDENCE
git diff -- catalog/electrs.json > .state/build-guide/local-catalog.patch || true

echo "== [5/6] assemble + verify image =="
cd "$JV_REPO"
$SUDO bash image/build-pi.sh \
  "$JV_BASE" "$JV_CORE" "$JV_REPO/target/release/justverify" \
  "$JV_ELECTRS" "$JV_TAG" "$JV_MEMPOOL" \
  2>&1 | tee .state/build-guide/image-build.log
$SUDO bash image/verify-pi.sh "dist/justverify-$JV_TAG.img.xz" \
  2>&1 | tee .state/build-guide/image-verify.log

echo "== [6/6] checksum + extract =="
cd "$JV_REPO"
$SUDO chown "$(id -u):$(id -g)" dist/justverify-"$JV_TAG".* dist/os-packages.tsv dist/SHA256SUMS
cd dist
xz -t "justverify-$JV_TAG.img.xz"
xz -dk "justverify-$JV_TAG.img.xz"
sha256sum "justverify-$JV_TAG.img.xz" "justverify-$JV_TAG.img" \
  > "justverify-$JV_TAG-SHA256SUMS"
sha256sum -c "justverify-$JV_TAG-SHA256SUMS"
cd "$JV_REPO"
dpkg-query -W > .state/build-guide/builder-packages.tsv
git diff --binary > .state/build-guide/local-source.patch || true

echo "BUILD PIPELINE COMPLETE: dist/justverify-$JV_TAG.img.xz"
