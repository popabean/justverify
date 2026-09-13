# Build a JustVerify image from GitHub

[한국어](ko/BUILD.md) · [日本語](ja/BUILD.md) · [Install a prebuilt image](INSTALL.md)

This guide compiles JustVerify, electrs and mempool, downloads their locked libraries, and assembles a Raspberry Pi 5 ARM64 image. Bitcoin Core comes from its official **signature-verified binary archive**; Pi OS and Debian packages are prebuilt upstream inputs. This is not a source build of every OS package or Bitcoin Core.

The actual build steps live in one script, [`scripts/build_image.sh`](../scripts/build_image.sh) — this guide does not duplicate them. CI (`.github/workflows/build-image.yml`) runs the identical script, so there is exactly one place that defines "how JustVerify is built"; if you change the process, change the script and both the manual guide and CI pick it up.

Use current `main` with this guide and record its commit. The immutable `v0.1.0-beta1` tag predates these instructions. Your local image is a new artifact: it does not inherit the published beta1 signature or test results. Whole-image byte-for-byte reproducibility is **not established**.

## 1. Prepare an isolated builder

Use **Debian 13 ARM64**, Python 3.13, systemd, a normal user with sudo, and working loop devices/mount/chroot. Plan for 4 CPU cores, 8 GB RAM and 80 GB free on a Linux filesystem. These are conservative allocations, not measured minimum requirements. Both the checkout and `/var/tmp` need space. Do not use a running node or connect its data drive to the builder.

On Apple Silicon, install Debian 13 ARM64 in a VM and run the script **inside Linux**; see the [Debian ARM64 installation guide](https://www.debian.org/releases/trixie/arm64/). macOS cannot run the assembler directly. Intel/x86 cross-compilation and macOS shared folders are not validated build paths. An unprivileged container works if it has real loop devices and can `mount`/`chroot` (this is how CI runs it, in a `--privileged` container); an unprivileged container without that access does not.

The script operates on newly created **regular image files**. Never supply a physical disk such as `/dev/diskN`, `/dev/sdX` or an NVMe device.

| Input | Version/source control |
|---|---|
| JustVerify/Rust libraries | Recorded Git commit, `rust-toolchain.toml`, `Cargo.lock`, `cargo --locked` |
| Pi OS Lite ARM64 | `catalog/pi-base.json`: 2026-06-18; compressed and extracted SHA256 |
| Bitcoin Core | 31.1 in image; 22.0 for compatibility tests; `catalog/trusted-builders.json`, GPG signature and SHA256 |
| electrs | `catalog/electrs.json`: 0.11.1, commit `35216c6d30148be8e6763d913d437330f431fc03`, source/Cargo.lock hashes |
| mempool | `catalog/mempool.json`: 3.3.1, commit `9332d9db97bcc7beed079acc8f79aa21c9b12a3b`, npm 11.8.0, NAPI CLI 2.18.0 and dependency locks |
| Python/browser | Hashed Python wheels in `web/requirements.arm64.lock`; vendored browser assets in `web/static` |
| OS libraries | apt packages; actual image inventory in `dist/os-packages.tsv`; the entire apt graph is not snapshot-locked |

## 2. Clone and run the build script

```bash
git clone --branch main --single-branch https://github.com/dontrustjustverify/justverify.git
cd justverify
sudo bash scripts/build_image.sh 0.1.0-beta1-local1
```

The tag (`0.1.0-beta1-local1` above) becomes part of the output filenames; pick a new one for each attempt. The script:

1. Installs the pinned apt packages (Node, MariaDB and the rest) and checks loop-device support.
2. Installs the Rust 1.98.0 and 1.84.1 toolchains via rustup.
3. Downloads and hash-verifies the Pi OS base image and Bitcoin Core (31.1 and 22.0), then compiles JustVerify, electrs and mempool.
4. Creates an isolated, unprivileged `justverify` account and MariaDB socket, and runs the **real regtest integration tests**: actual transaction creation/signing/broadcast, mempool entry, mining, two confirmations, Core/electrs/mempool height 107 and tip agreement, address lookup, WebSocket updates and service/Core interruption/recovery.
5. Assembles and verifies a pristine image (`image/build-pi.sh` + `image/verify-pi.sh`): one OS partition plus a separate data partition, machine identities removed, caches cleared, unused blocks zeroed, then compressed.
6. Checksums and extracts the result.

It refuses to run if a prior `justverify` account/runtime already exists (use a clean isolated builder) or if the output tag's files already exist (pick a new tag). It never bypasses a source, signature or dependency hash failure — see the qualify-electrs step it runs internally, which will refuse to package a newly compiled electrs binary that hasn't passed both regtest runs.

No Docker daemon is required to *run* the script itself on a real Debian 13 builder; CI happens to run it inside one for OS-package-pinning reasons (see below), not because the script needs it.

## 3. Outputs

| Output | Purpose |
|---|---|
| `dist/justverify-<tag>.img` | Extracted image to select in balenaEtcher |
| `dist/justverify-<tag>.img.xz` | Compressed image for download/storage |
| `dist/justverify-<tag>-SHA256SUMS` | Both file hashes; check from `dist/` |
| `dist/justverify-<tag>.layout.json` / `.size-audit.json` | Partition layout and size audit |
| `dist/os-packages.tsv` | Actual image package inventory |
| `.state/build-guide/` | Source commit/patch, logs, local component/test evidence |

SHA256 is an integrity check, not a publisher signature. A script run like this produces an unsigned local build. Redistribution also requires your exact source/patches, corresponding component sources/licenses, support/test report and your own signing process. See [third-party notices](../licenses/THIRD_PARTY_NOTICES.md) and the [release source assets](https://github.com/dontrustjustverify/justverify/releases/tag/v0.1.0-beta1). Do not reuse the official signature for a changed file.

Follow [installation](INSTALL.md) with Etcher validation enabled. Direct XZ input failed checksum validation on the tested macOS/Etcher 2.1.6 setup; the **extracted IMG** passed. Then test initial setup, Core/electrs/Tor, mempool port 3006, LAN/onion wallets, reboot and recovery on a physical Pi 5. Mark unexecuted tests `NOT RUN`/`BLOCKED`. [TESTING.md](TESTING.md) lists the remaining release gates.

## 4. CI

`.github/workflows/build-image.yml` runs `scripts/build_image.sh` on GitHub's free `ubuntu-24.04-arm` hosted runner, inside a `--privileged debian:trixie` container (the runner's own Ubuntu base doesn't have the pinned Debian package versions this script installs). It sets `JV_REPO` to the already-checked-out working tree so the script builds the commit under test instead of re-cloning `main`; everything else is identical to a manual run. It is manually/branch-triggered, not on every push, and keeps artifacts for a few days, not indefinitely — a full image build is expensive to run on every commit.

## Troubleshooting and resuming

| Symptom | Action |
|---|---|
| Root/architecture or loop/mount error | Use ARM64 Linux with sudo and loop devices; never supply a physical disk instead |
| `libclang` / RocksDB error | Check clang, libclang-dev and build-essential; preserve the compile log |
| Mempool Rust error | Check `RUSTUP_TOOLCHAIN=1.84.1`; do not regenerate dependency locks to hide a failure |
| Test permission denied | Check parent-directory traversal and public binary/source permissions for `justverify`; keep wallet/runtime directories private |
| Port occupied / failed test state exists | Stop only your own test process, keep old evidence and retry (the script uses fresh `tests-<version>` paths per run) |
| `electrs differs from tested build` | The script's qualify step re-derives this from the regtest runs it just performed; do not hand-edit the hash |
| Image output/intermediate exists | Keep failed logs/files; use a new tag or fresh checkout; never overwrite a release image |
| Build killed / disk full | Check RAM and free disk including `/var/tmp`; reduce `CARGO_BUILD_JOBS` or enlarge the builder |

To resume a failed attempt, re-run with the same `JV_REPO`/`JV_WORK` exported and a fresh output tag; the script reuses verified downloads it finds and refuses to overwrite existing output.
