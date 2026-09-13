#!/bin/bash
# CI translation of docs/BUILD.md, run as root inside a --privileged debian:trixie
# container on top of a GitHub-hosted ubuntu-24.04-arm runner.
#
# Deviations from BUILD.md, and why:
#   - No git clone: the repo is already checked out and bind-mounted at $JV_REPO.
#   - No dedicated non-root build user for cargo/npm: this container is a throwaway
#     CI sandbox, not a persistent builder machine, so the isolation BUILD.md asks
#     for (a normal sudo user) doesn't apply the same way. Compilation runs as root.
#     Section 4's unprivileged "justverify" test account is kept as documented,
#     since that isolation is load-bearing for the test itself, not just hygiene.
set -euo pipefail

test "$(uname -sm)" = "Linux aarch64"
test "$(. /etc/os-release; echo "$VERSION_ID")" = "13"

echo "== [1/6] apt packages =="
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install --no-install-recommends -y \
  git curl ca-certificates gnupg build-essential clang libclang-dev \
  cmake pkg-config libssl-dev python3 python3-venv xz-utils tar gzip patch \
  file jq parted fdisk e2fsprogs dosfstools zerofree util-linux udev kmod systemd \
  openssl npm nodejs=20.19.2+dfsg-1+deb13u2 \
  mariadb-server=1:11.8.6-0+deb13u1
python3 -c 'import sys; assert sys.version_info[:2] == (3, 13)'
modprobe loop || true
losetup --find

echo "== [2/6] toolchains =="
export JV_REPO=/repo
export JV_WORK="$(mktemp -d /var/tmp/justverify-ci.XXXXXX)"
cd "$JV_REPO"
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
export JV_BASE="$JV_WORK/raspios-lite-arm64.img.xz"
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
export JV_CORE="$JV_REPO/.cache/core/31.1/aarch64-linux-gnu/bitcoin-31.1"
export CARGO_BUILD_JOBS=4
cargo +1.98.0 build --release --locked 2>&1 | tee .state/build-guide/cargo-build.log
cargo +1.98.0 test --locked 2>&1 | tee .state/build-guide/cargo-test.log
RUSTUP_TOOLCHAIN=1.98.0 python3 scripts/build_electrs.py "$JV_WORK/electrs" \
  2>&1 | tee .state/build-guide/electrs-build.log
JV_ELECTRS_COMMIT=$(jq -r .commit catalog/electrs.json)
export JV_ELECTRS="$JV_WORK/electrs/electrs-$JV_ELECTRS_COMMIT/target/release/electrs"
RUSTUP_TOOLCHAIN=1.84.1 bash scripts/build_mempool.sh "$JV_WORK/mempool" \
  2>&1 | tee .state/build-guide/mempool-build.log
export JV_MEMPOOL="$JV_WORK/mempool/bundle"
(cd "$JV_MEMPOOL" && sha256sum -c SHA256SUMS > /dev/null)

echo "== [4/6] real integration tests (regtest) =="
cd "$JV_REPO"
if getent passwd justverify >/dev/null || test -e /opt/justverify/venv; then
  echo 'Use a clean isolated builder: test account/runtime already exists.'
  exit 1
fi
useradd --system --user-group --create-home \
  --home-dir /var/lib/justverify --shell /usr/sbin/nologin justverify
install -d /opt/justverify
python3 -m venv /opt/justverify/venv
/opt/justverify/venv/bin/pip install --require-hashes --only-binary=:all: \
  -r "$JV_REPO/web/requirements.arm64.lock"
sha256sum "$JV_ELECTRS" > .state/build-guide/electrs-before-tests.sha256
for version in 31.1 22.0; do
  core="$JV_REPO/.cache/core/$version/aarch64-linux-gnu/bitcoin-$version"
  install -d -o justverify -g justverify "$JV_WORK/tests-$version"
  state="$JV_WORK/tests-$version/jv-mempool-test-$version"
  su -s /bin/bash -c "/opt/justverify/venv/bin/python '$JV_REPO/tests/mempool_live.py' \
    --state '$state' --core '$core/bin' --electrs '$JV_ELECTRS' \
    --bundle '$JV_MEMPOOL' --version '$version'" justverify
  cat "$state/result.json" > ".state/build-guide/regtest-$version.json"
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
bash image/build-pi.sh \
  "$JV_BASE" "$JV_CORE" "$JV_REPO/target/release/justverify" \
  "$JV_ELECTRS" "$JV_TAG" "$JV_MEMPOOL" \
  2>&1 | tee .state/build-guide/image-build.log
bash image/verify-pi.sh "dist/justverify-$JV_TAG.img.xz" \
  2>&1 | tee .state/build-guide/image-verify.log

echo "== [6/6] checksum + extract =="
cd "$JV_REPO"
cd dist
xz -t "justverify-$JV_TAG.img.xz"
xz -dk "justverify-$JV_TAG.img.xz"
sha256sum "justverify-$JV_TAG.img.xz" "justverify-$JV_TAG.img" \
  > "justverify-$JV_TAG-SHA256SUMS"
sha256sum -c "justverify-$JV_TAG-SHA256SUMS"
cd "$JV_REPO"
dpkg-query -W > .state/build-guide/builder-packages.tsv
git diff --binary > .state/build-guide/local-source.patch || true

echo "CI BUILD PIPELINE COMPLETE"
