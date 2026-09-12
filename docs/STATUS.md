# 진행 상태

## 게시 확인

- 공개 저장소 https://github.com/dontrustjustverify/justverify 에 전체 소스와 영어/한국어/일본어 README를 게시했다. 첫 공개 snapshot df1535dbb66f92faf6df00f0521ec5981e4d0b10, 원본 작업 tree ea5da508979fdbf6c37a3c1c8b457c1c64eaad78. 후속 문서는 같은 main에 반영한다.
- 공개 사본1396파일의 개인키/GitHub token 패턴 및 주요 README·설치·빌드 상대 링크 검사 PASS. 개발자 Git 이력·.state·캐시·시험 디스크·.DS_Store 제외. GitHub UI와 API에서 올바른 계정/public/main 및 README 렌더링을 확인했다. 사용자 승인된 CLI 인증을 사용했고 암호를 소스나 이미지에 기록하지 않았다.
- 이미지 원본·소스·검증 결과·설치/복구·체크섬·실험용 서명은 dist의 같은 beta1 이름으로 묶는다. 공개 GitHub 소스와 로컬 설치 이미지 전달을 구분하며, 전체 OS 바이너리의 공개 배포 및 최종 안정판 수용 판정은 아직 아니다.

## 현재 — beta1 이미지 검증·소스 게시 준비

- 요청한 원형 BTC favicon, 전체 문구, 글자색 계층, 내장 멤풀3006 및 한·영·일 README 완성. 제품 최종 소스6f7f7e1, ARM 앱bd4296a. 이후 변경은 시험·문서다.
- 최종 pristine 이미지 `dist/justverify-0.1.0-beta1.img.xz`:654,231,760bytes(624MiB), raw6,444,548,096bytes. SHA25631ed2db7a8f16de4a0947eb5468cb61054a3eeff4ea6001c5ebb86498bed462d. Mac xz·raw SHA와 Linux 원본 일치 및 전체 offline 검사 PASS. evidence/beta1-image-file.json, beta1-image-size.json.
- 실제 첫 등록/데이터 UUID 확장/Core/electrs/TLS·지갑·PSBT/HTTP·session·favicon/TUI·QR/내장 멤풀 SQL·3언어·Core tip PASS. Tor100% 뒤 onion timeout으로 cold-boot 전체 FAIL 유지: evidence/image-beta1-r3-boot.json.
- 같은 실패 clone에서 신원·설정·데이터를 재생성하지 않은 별도 복구와 실제 재부팅 PASS2회: evidence/image-beta1-recovery.json. 같은 UUID/tip/인덱스/지갑/SSH·TLS·Tor 신원/멤풀 SQL·3언어/Core tip, 실제 onion RPC200 및401/404 차단을 양쪽 실행에서 확인. cold-start 실패를 소급해서 PASS로 바꾸지 않음.
- 이전 r1/r2 설치 실패 및 원인 보존. r3 첫 복사는 Mac 공간 부족으로5.4GB에서 잘렸고 그 불완전 사본의 probe도 FAIL(image-beta1-r3-truncated-copy.json). 전체 크기를 확인한 새 사본으로 재시험. 재생성 가능한 Mac 실패 디스크3개만 정리, 테스트/로그/결과 및 사용자 데이터 보존.
- GitHub dontrustjustverify/justverify 새 저장소 생성, 사용자 승인 후 GitHub CLI 인증 완료. 다른 계정 connector 사용 안 함. 비밀정보·개발 Git 이력 없는 소스 snapshot 게시와 서명 번들 마무리 중.
- 새 beta1 Pi5 실기/실제 휴대폰·카메라/24시간/전체 정책 의미·업데이트 실패·새 UUID 백업 복원/OS byte 재현성·전체 OS 공개 배포 소스 검토는 남음. 기존 Pi mainnet은 변경하지 않음. 전체 정상작동 확인 완료 판정 아님.
- 재개: `.state/release-beta1/`, Linux `/home/builder/jv-build-beta1-r3`. 검사한 원본은 dist, 부팅한 비공개 clone은 .state/vm/probe-beta1-r3.img. 후자는 NVMe 기록·배포 금지.

## 재개 체크포인트 — beta1 r3 설치·부팅 검증 중

- 두 번째 이미지(r2)도 initial apply에서 rolled_back. strict version-service namespace가 DATA/instances만 쓰기 허용하므로 root helper도 DATA/mempool 생성에 EROFS를 받는다. 실제 systemd namespace 시험 PASS로 원인 확인(`.state/release-beta1/namespace-proof.log`); 기존 권한 경계를 넓히지 않았다.
- 제품6f7f7e1: node-ready로 등록·UUID·선택·binary 검증 후, 독립 root oneshot justverify-mempool-data가 고정 DATA/mempool만 dir_fd/O_NOFOLLOW로 준비한다. 비권한 mempool은 이 준비 단위 이후 시작한다. profile helper는 기존 좁은 API 안에서 mempool을 기존 서비스와 함께 stop/start한다.
- r3 builder `/home/builder/jv-build-beta1-r3`, source6f7f7e1, binarybd4296a, native bundle c6581327... 불변. `.state/release-beta1/rebuild-namespace.sh`, `image-r3-build-verify.log`. r2 pristine raw의 SHA 검증 PASS 후 복사·소스 수정·e2fsck/zerofree; 제품 압축과 시험 복사본은 별도.
- 실제 시험 r3 Mac복사→12GiB/4096MiB 두 번 부팅 세션32468 실행 중; `.state/vm/probe-beta1-r3.img`, `image-r3-boot-console.log`, `docs/evidence/image-beta1-r3-boot.json`. r3 결과가 나오기 전 성공으로 세지 않는다. r1/r2 Mac실패 디스크·보고서 유지; Linux 중복 시험 복사본만 공간 확보를 위해 제거.
- GitHub repository는 빈 상태이며 push·최종 manifest·서명은 남았다. 올바른 계정 dontrustjustverify에 대한 새 CLI 인증 승인만 게시 직전에 필요하다. 소스 확정 전 승인 요청 없음.

## 이전 체크포인트 — beta1 초기 등록 수정 후 이미지 재시험 중

- 제품 최신31ee41f: 빈 볼륨 보호 목록을 그대로 두고, firstboot의 mempool 폴더 생성을 제거했다. root의 고정 profile helper가 검증된 instance 활성화 후에만 폴더를 생성하고 mempool을 시작/정지한다. mempool unit에 node-ready 조건과 기존 guard를 연결했다.
- 첫 이미지 SHA47e38af2...는 파일 검사 PASS/실제 첫 등록 FAIL. Mac `.state/release-beta1/rejected/justverify-0.1.0-beta1-initial-setup.img.xz`, 실패 VM `.state/vm/probe-beta1-final.img` 및 evidence/image-beta1-boot.json 보존. NVMe 기록이나 공개 배포 없음.
- 실패 데이터 파티션을 읽기 전용으로 검사해 instances/justverify-volume.json/lost+found 외의 mempool 폴더가 정확히 기존 guard에 걸림을 확인했다. NBD 디버그 연결은 해제했다. guard를 완화하거나 기존 데이터를 삭제해 통과시키지 않았다.
- 수정 candidate는 Linux `/home/builder/jv-build-beta1-r2/.state/justverify-0.1.0-beta1.img`. 원본47e38af2의 unbooted 복사본에 firstboot/profile helper/mempool unit만 수정, e2fsck/zerofree 후 압축과 독립 boot-copy 준비. `.state/release-beta1/rebuild-initial-setup.sh`, `image-r2-build-verify.log`. `JV_BETA1_R2_PROBE_READY` 이후 `/var/tmp/jv-virt-probe-beta1-r2.img`를 Mac 새 .state/vm/probe-beta1-r2.img로 복사해12GiB/4096MiB, rootPARTUUID19454452-38bc-5ef7-940a-e210def4ee55로 실제 두 번 부팅할 것.
- tests/prepare_image_boot_probe.sh는 같은 pristine bytes의 .img 입력도 지원하도록 확대했다. 압축 무결성/원본 대조/실제 부팅의 기존 assertions는 유지한다. 첫 이미지 실패 결과는 별도로 보존한다.
- 추가 실제 Core22.0/electrs0.11.1/mempool3.3.1 전체 regtest 거래·SQL/서비스 재시작 PASS, tx01197c2bd6be7e2eb848ba2e297242d0a07c8239d4c6f7c3c38d146875cacf08/107높이/2확인. evidence/beta1-mempool-core22.json. 이 결과를 미시험 중간 버전 전체의 통과로 세지 않는다.
- 임시 UI·SSH forward·regtest 서버 정리, 시험 지갑 제거 및 로그74개 보존. 실제 Pi dev16은 읽기 확인만 했고 main440886/966685 IBDtrue·Core/electrs/Tor/web active였다.
- GitHub dontrustjustverify/justverify 공개 빈 저장소 생성 완료. `.state/release-beta1/public-source`에 개발자 Git 이력·.state 없이 게시용 사본 준비. 기존 Git credential은 없고 connector는 다른 계정이므로 push는 아직 하지 않았다. GitHub CLI2.100.0 설치; 이미지와 게시용 소스가 확정되면 사용자에게 필요한 GitHub 새 접근 권한 인증을 한 번만 요청한다. 암호는 소스/로그/이미지에 저장하지 않는다.

## 최신 — 0.1.0-beta1 UI·내장 mempool 작업 중 (2026-09-12)

- 기존 dev16 변경과 실기 데이터 보존, 작업 branch codex/dev17-mempool. BTC 원형 favicon·요청한 전체 문구·모바일 헤더·글자색 선택과 4색 계층·상단 멤풀 링크 구현. 실제 브라우저 Amber/390px 폭 검사 PASS; 나머지 색과 이미지 부팅 검사는 진행 중.
- 공식 mempool v3.3.1 / 9332d9db97bcc7beed079acc8f79aa21c9b12a3b, Umbrel apps 01de454e를 검토. Node20.19.2·MariaDB11.8.6·Rust GBT를 ARM 네이티브로 빌드. 런타임만 이미지에 포함, backend8999 loopback/SQL private Unix socket, LAN3006 HTTP. 원본 소스·수정 patch·lock·AGPL 고지를 이미지 /source/로 제공. 외부 fiat feed는 비활성이고 값은 —로 표시, 한국어/영어/일본어만 빌드.
- 실제 격리 regtest31.1+electrs0.11.1+MariaDB+mempool HTTP 거래 생성/서명/전파/미확인/블록106·1확인/주소잔액/실시간 WebSocket/DB·backend 재시작 PASS. tx d5ed8daf78c236852623a54e617e43f087315055e0ce11b2c9cdb17455c3993c, tip4bd8fe3d28bf6fe0919a661775efb156dd4b50ef5a8b4fe27dd77a3bef67b997. .state/release-beta1/mempool-live-ws-retry.log. 초기 fixture권한/WS 정렬 가정 오류와 수정·재시험 기록 유지. 테스트 데이터나 mainnet 자금 대체 없음.
- cargo test --locked 및 ARM 앱 빌드 PASS. frontend npm9 잠금 해석 실패를 npm11.8.0으로 해결; locale 설정/patch 포맷 수정 후 3개 locale build PASS. 독립 소프트웨어를 추가했으므로 이전 Pi/dev16 검증을 새 이미지 통과로 간주하지 않는다.
- 영어 README.md, docs/ko/README.md, docs/ja/README.md와 빌드 안내 작성. GitHub 사용자 브라우저 로그인 계정 dontrustjustverify 확인. 설치 connector는 다른 계정이므로 사용하지 않음. 새 repository/업로드 아직 NOT RUN. 인증정보는 공개 파일·이미지에 넣지 않는다.
- 추가 프로필 시험에서 Core 재시작 뒤 독립 fixture의 electrs 프로세스 종료를 발견. 기존 PASS는 Core/멤풀 tip·cache까지이며 electrs 재연결 주장은 불충분했다. 상시 electrs header 높이·hash 재확인과 실제 indexer 재시작/주소 조회 assertions를 추가, 새 regtest 재시험 중. 앞선 로그와 FAIL 보존.
- 새 이미지47e38af2는 offline/hash PASS 후 첫 부팅에서 초기 등록 FAIL. firstboot가 mempool 폴더를 미리 만들어 기존의 엄격한 빈 볼륨 보호 검사를 위반한 것이 원인이다. 검사 허용 목록을 완화하지 않고, 검증된 프로필 활성화 후에만 폴더 생성·서비스 시작하도록 수정 중. 실패 이미지/보고서 보존, 아직 최종 설치 후보로 전달하지 않는다.
- 최신 재시험: 실제 electrs hash/높이/주소 확인을 포함한 regtest107·2확인 PASS(164c84cf7410b54bdcbab86555797d07759b8a220048f9e1939d217479f18477), chain 불일치 차단·프로필 전환·기존 SQL 보존 PASS. 프로필 전환 동안 이전 running 상태가 남는 짧은 구간도 수정(aa2f561). evidence/beta1-mempool-{regtest,profile}.json.
- 재개: mempool 잠금파일·최종 bundle → 런타임/화면 검토 → 새 justverify-0.1.0-beta1.img.xz 빌드·offline 검증·실제 VM 두 번 부팅 → 결과·체크섬·소스 정리 → 올바른 계정 GitHub 게시. 새 Pi 실기/모바일/기존 S4 미완료 항목은 유지한다.

## 최신 — dev16 새 Pi5 실기 부팅·연결·재부팅 검증 (2026-09-12)

- 사용자가 NVMe를 Pi5에 장착한 뒤192.168.10.47로 접속. 새 dev16 앱 SHA/정적 파일13개 일치, NVMe 데이터 영역1,994,492,288,512bytes 확장, UUID6c03c044-c89d-410e-9da9-5a48a8920d5e. 최초 사용자 관리자 등록 완료와 main/31.1 자동 시작을 관측했다. root 키/justverify 기본 암호 SSH·IP/mDNS HTTP200 PASS. 사용자 암호/설정 변경 없음.
- 실제 비권한 TUI120/80/42열·정상 종료, 별도 loopback 임시 계정의 실제 웹/공유 수집기/고정 TUI WebSocket·세션 새로고침·Origin/CSRF·logout PASS. LAN/Tor QR 디지털 해독 및 실기LAN50002 TLS hostname/certificate/QR fingerprint 일치. 실제 HDMI 사진과 휴대폰 카메라·앱 연결은 NOT RUN.
- Pi 독립 regtest 실제 지갑 생성/자금/거래 서명/Electrum broadcast/Core mempool/확인0→1→2/수신 잔액/electrs 인덱스와 재시작 PASS. 실제 Pi 재부팅 후 같은 테스트 체인·지갑·인덱스를 다시 열어103 높이/tip/2확인/잔액 유지 PASS. mainnet 거래나 실제 자금 사용 없음. 결과/로그를 Mac에 보존한 뒤 시험용 지갑 개인키·데이터 제거.
- 새 Pi의 Tor P2P 실제 외부 handshake PASS(6.400초, 재부팅 후16.853초). 기존 RPC onion과 패키지 그대로의 gateway를 임시 node-read 계정으로 시험: 외부 Tor200/main 응답, 무인증401/허용 밖 읽기RPC403/관리 경로404 PASS(12.537초). 임시 계정 폐기와 listener 종료 완료; 운영 Remote RPC는 원래 기본 비활성 유지. 이전 VM RPC timeout은 별도 FAIL 기록 유지.
- 실제 웹 power preview/apply→기기 API로 재부팅,44.6초 후 새 boot ID/SSH. 설정·owner·기기 키·Tor 신원14파일 hash, NVMe UUID, 앱/웹 bytes 유지. main265712→273501 및 과거tip의 조상 일치 PASS. manager만 강제 종료하여 Core PID 유지·신선한 수집 복구4.81초 PASS. manager NRestarts2는 두 번의 의도적 시험이다.
- 새 설정28개 암호화 백업 생성·복호화 검사 및 Mac 전송 SHA PASS, `.state/pi5-install/dev16-postboot-backup/`. 기존 재설치 전 백업 보존. 새 백업의 실제 restore는 하지 않았다.
- 최종 저장 관측12:50:06UTC: main303442/966678, IBD=true, peers10, Tor100%, 서비스14개active/failed0. electrs는 Core IBD 대기이며 전체 인덱싱/지갑 준비 완료가 아니다. 증거 `docs/PI5_DEV16_VALIDATION.md`, `docs/evidence/dev16-pi-hardware.json`, `dev16-pi-regtest-transaction.json`.
- 실패/재시험: SSH PTY 출력 배출·UTF-8 상태, 시험 폴더 권한, 임시 웹 시작 race, manager 첫 sample 대기, ps USER 축약을 시험 실행기에서 수정. 제품 코드/현재 이미지/서명 번들은 불변. 신규 실기 시험 코드와 문서만 저장, .DS_Store 보존.
- 재개: Pi를 켜둔 채 기존 main/31.1 동기화 유지 → IBD=false/최근 블록 및 electrs 높이·tip 일치 확인 → 실제 모바일·HDMI·24시간 및 남은 정책/업데이트 실패/새 볼륨 복원/OS 재현 빌드 검증. 자동 재접속/예약 실행기는 등록하지 않았다. 전체 정상작동 완료 판정은 아직 아니다.

## 최신 — dev16 NVMe 기록·검증·추출 완료 (2026-09-12)

- 사용자가 연결한 유일한 외장 물리 디스크 `/dev/disk6`, GEIL RTL9210 Media, 정확히2,000,398,934,016bytes 및 기존 bootfs/Linux/Linux 배치를 확인하고 허용된 NVMe 대상으로 선택했다. USB 브리지는 원래 NVMe serial을 노출하지 않았고 raw ext4 UUID 읽기는 Mac 권한 때문에 미실행; 독립 UUID 대조를 했다고 주장하지 않는다.
- balenaEtcher2.1.6으로 `justverify-dev16-pi5-private.img`(6,444,548,096bytes, SHA2562e65e50b536c9fac6e48e8e63fcdff8b3d0d1dcfe891642bd54c87d9cbdecefe) 기록 PASS. 실제 Validating17%·82% 이후 Flash Completed /1 Successful target 확인. 검증 건너뛰기 사용 없음. 독립 전체 디스크 SHA256 검사는 별도 미실행이다.
- 최초 Starting 단계가 종료된 뒤 Etcher 보조 프로세스의3434포트 충돌로 재시작 시 이미지/장치 검색도 멈췄다. macOS 로그에서 이전 helper 점유 EADDRINUSE 확인; 점유 해제 후 UI 재시작으로 복구했다. 첫 실패와 재시도 근거는 `.state/pi5-install/dev16-etcher-progress.json`, `dev16-etcher-helper-system.log`에 보존했다.
- 기록 후 boot536.9MB/root5.4GB/factory data536.9MB 및 확장용 미할당 공간 확인. `diskutil eject /dev/disk6` 성공. Mac에서 물리적으로 분리할 수 있는 상태다. 공개 요약 `docs/evidence/dev16-etcher-flash.json`.
- 다음 재개: 사용자가 NVMe를 Pi5에 장착·부팅하고 IP를 알려주면 새 SSH host key를 이전 것과 구분하여 연결하고 초기 확장/웹 최초 등록/Core·electrs/Tor/설정·재부팅을 실기 검증한다. 새 이미지 Pi 부팅 NOT RUN, 기존 Tor 미통과와 나머지 릴리스 게이트는 유지한다. 이미지와 기존 서명 번들은 변경하지 않았다.

## 최신 — dev16 기록 직전 재검증 (2026-09-12)

- 사용자 요청으로 현재 소스5cdc9cd와 이미지 조립 소스b3c5f5b의 차이를 대조했다. 이후 변경은 시험 실행기/보고서뿐이며 최신 제품 수정은 모두 기존 dev16 이미지에 포함되어 있다. 이미지 bytes와 서명된 번들을 불필요하게 다시 만들거나 덮어쓰지 않았다.
- 공개 개발 번들9개 파일의 서명·체크섬, 개인 설치 manifest 서명, pristine raw 및 최종 xz SHA256, xz 무결성 모두 PASS. 증거 `.state/pi5-install/dev16-preflash-bundle-verification.json`, `dev16-preflash-ready.json`. 압축577,804,520bytes / raw6,444,548,096bytes.
- Mac 외장 물리 디스크 조회 결과 없음. balenaEtcher 준비는 Mac 잠금으로 제어 불가하여 이미지 선택/기록을 하지 않았다. 다음 재개: Mac 잠금 해제 및 지정 NVMe 연결 → 모델/용량/장치 번호 재확인 → pristine raw를 Etcher로 기록·검증 → 사용자 Pi5 부팅 후 실기 시험. 자동 대기/재실행기는 등록하지 않았다.
- 실제 Pi는 이 작업에서 종료하거나 변경하지 않았다. Tor RPC onion 미통과 및 새 이미지 Pi 부팅 NOT RUN은 유지한다.

## 최신 — Tor VM/Pi 원인 분리 (2026-09-12)

- 현재 Pi P2P onion에 외부 builder Tor 및 실패 VM Tor client 양쪽으로 실제 Bitcoin version/verack/ping/pong PASS(8.691초/21.587초). Pi NTP yes·Tor100%. Pi 설정/데이터 변경 없음.
- 같은 VM의 Electrs onion도 외부 client에서 실제 electrs0.11.1/height1 응답 PASS. VM 전체 Tor 장애가 아니며 VM RPC용 onion이 SOCKS CONNECT 단계에서 timeout이다.
- Tor info에 introduction 경로2/3 대기 반복.240초 control events에 RPC descriptor 게시 없음, 해당 intro circuit TIMEOUT4/DESTROYED2. Tor 공식 f3d28b2의 게시 보류 조건과 일치. 특정 중계기/링크의 더 깊은 원인은 미확정. TOR_VM_PI_DIAGNOSIS.md와 evidence/tor-vm-pi-diagnosis.json. 기존 FAIL/부분 검증 결과 유지.
- 추적 전용 설정 제거·동일 Tor 신원·원래 서비스 active 확인 후 시험 VM만 종료. 로그/재현 명령은 .state/tor-rootcause/. 원본 dev16 이미지/서명 불변. Pi RPC onion 및 새 이미지 Pi 부팅은 별도 미검증이며 실제 Pi는 계속 실행 중.

## 현재 — dev16 이미지 준비·실기 재설치 대기 (2026-09-12)

- 이미지 조립 소스 b3c5f5b, ARM 런타임 abfce56과 동일. Linux `/home/builder/jv-build-dev16`, `.state/release-dev16/image-final-build-retry.log` exit0. 최초 압축은 추가 APT 캐시 제거를 위해 중단했고 raw를 재조립했다. 실패/중단 로그 보존. 최종 root 할당량1,793,581,056bytes, raw6,444,548,096bytes, 원본 xz577,803,744bytes. SHA256889bf8ace5b0aa8d5731ae92867e100867c44c1d0a46c3db585fc6276e373bdc. Mac xz 무결성과 Linux 전체 offline 검사 PASS.
- 최종 소스/검증기 버전과 각 파일 hash는 dev16 manifest 및 서명된 SHA256SUMS가 기준이다. 조립 뒤 변경한 scripts/run_image_probe.py(19a6335)는 시험 clone의 디스크만12GiB로 늘려 실제 NVMe 기록 조건을 재현한다. 제품 파티션 확장 코드와 검증 기준은 바꾸지 않았다.
- Pi 임시 UI 서비스/계정/SSH forward 정리 완료. 실제 Pi Core/electrs/Tor/web/device active. 암호화 설정 백업은 .state/release-dev16/preflash-backup (28파일, Mac 독립 복호화·hash PASS). Pi 아직 종료하지 않음.
- 개인 SSH 공개키 복사본 작성·offline검사·실제 root 공개키/justverify 암호 SSH PASS. Etcher용 pristine raw `.state/pi5-install/justverify-dev16-pi5-private.img`, SHA2562e65e50b536c9fac6e48e8e63fcdff8b3d0d1dcfe891642bd54c87d9cbdecefe. 원본 압축 bytes와 독립 raw hash 일치 PASS. 부팅한 `.state/vm/probe-dev16-*.img`에는 시험 계정이 있으므로 절대 기록하지 않는다.
- 첫 VM 시험은 확장 공간 없는6.44GB 가상 디스크 때문에 data>1GiB assertion FAIL. 더 큰12GiB 디스크에서 제품 확장·고유 UUID·Core/electrs/TLS/watch-only/설정·HTTP/TUI/QR PASS, 실제 onion timeout으로 전체 FAIL. 새 복사본 재시험도 bootstrap62% timeout FAIL. 보고서3개 보존. 테스트 삭제·단축 없음.
- 같은 실패 clone의 신원/데이터를 유지한 별도 복구 및 실제 재부팅 검사: UUID·tip·인덱스·SSH/TLS/admin 신원·정책·watch-only/PSBT·HTTP/session/favicon·기본 언어·TUI PASS. Tor는100%가 되었지만 onion RPC timeout 지속 → PARTIAL. 별도 builder Tor client도 timeout, 기기 내부 실제 RPC gateway는200/regtest PASS. 근본 원인은 확정하지 않았고 키/데이터 재생성·우회 없음. docs/evidence/image-dev16-recovery.json. 시험 VM만 정상 종료했다.
- 장비용 최종 압축 `.state/pi5-install/justverify-dev16-pi5-final.img.xz`:577,804,520bytes, SHA2563af35a5ec4424f53a98c87dceba785d2de16834d22f21cd713f196d382f6d8c8. 앞선 fast 압축본과 같은 raw를 xz-6으로 다시 압축했으며 앞선 파일 보존. Etcher에는 검증된 pristine raw를 사용한다.

- 설정 아래 백업 및 복원/문제 해결; 저장장치 관리는 접힌 고급 항목. 기존 기능과 사용자 변경 보존. 근거와 증거는 docs/MINER_AND_IMAGE_DEV16.md.
- 실제 macOS/Linux regtest 및 Pi5 mainnet 읽기 관측으로 채굴 풀 표시 확인. Pi는 IBD 중이며 전체 동기화 완료가 아니다. HTTP favicon/로그인/세션과 모바일390px 정렬 확인.
- 개발 VM 가상 디스크만32→64GiB 확장, cloud-init 파티션/파일시스템 확장 확인. 기존 이미지나 데이터 삭제 없음.
- 개발 번들9개 파일의 실험용 서명·hash PASS: docs/evidence/dev16-bundle-verification.json. 최종 소스 archive commit a9992cd50f93373f46838a0e9c491c03c0b1a734, 조립 이후 변경은 검증기/보고서뿐이며 runtime 불변 대조 PASS. 개인 설치 manifest도 별도 서명했고 .state·시험 계정·개인키는 공개 번들에 포함하지 않았다.
- 재개 지점: 사용자 Pi 정상 종료/NVMe Mac 이동 → 새 장치 번호·GeIL P3A 2TB/WKFG3000369와 허용 대상 확인 → Etcher raw 기록 및 검증 → Pi 새 이미지 부팅·실기 검증. VM Tor 시간 초과는 미통과이며 실제 Pi에서도 원인 분리/연결 검증 필요. 새 Pi 부팅·실제 모바일·24시간·미완료 복구/정책/재현 빌드 게이트가 남았으므로 최종 릴리스 완료 아님.
- 현재 실제 Pi 마지막 읽기 관측: main blocks502698/headers966661, IBD=true, Core/electrs/Tor/web/device/manager active. `.state/release-dev16/pi-before-handoff.json`. 실제 Pi는 종료하지 않았다.

## 최신 검토 — 설정 보조 메뉴 필요성 비교 (2026-09-12)

- 사용자 요청으로 Umbrel 공식 소스 bfa79ed2와 현행 설치/백업/진단 문서를 비교했다. 결과 UMBREL_SETTINGS_UX.md. 초기 설정은 완료 후 상시 메뉴에서 제외, 단일NVMe 저장장치 설치 화면은 고급 복구로 이동, 백업 및 복원·문제 해결은 설정 하단 진입점으로 정리 권고. 기존 진단은 RPC 오류/갱신시각 표시이므로 전체 서비스 진단이라고 확대 해석하지 않음.
- 이번 요청은 비교 검토이므로 실행 코드·Pi 메뉴 변경 없음. 다음 메뉴 개편 시 이 근거를 사용하고 기존 복구 기능/테스트를 보존한다.

## 최신 재개 지점 — 일반 설정 Pi 적용·검증 (2026-09-12)

- 상단 로그아웃 SVG(로고21px/버튼16.8px), 실제 기기 정보·전원·계정·4개 테마·한국어/영어/일본어 웹 UI·Tor 관리 화면을 실제 Pi에 배포했다. 기존 native 상세 터미널 문구는 한국어 유지; 완전 번역으로 보고하지 않는다.
- 실제 HTTP/TLS 인증 회귀, Linux 계정·암호교체·세션폐기·설정 저장 API PASS. IP JSON의 빈 addr_info 예외를 수정 후 재시험 PASS.
- 실제 public Tor SOCKS 경유 로그인·Host/Origin 차단·실제 Core snapshot·RPC 별도 비활성 PASS. VM 재부팅 및 poweroff 후 재기동 PASS: boot ID 변화, 계정/테마/언어/Tor 설정 hash 불변, Core/electrs/web/device active.
- actual GPG 4개 Tor identity 백업·복구 회귀와 legacy optional preference/remote-web restore PASS. 최초 새 fixture의 /var symlink 경로를 resolve하여 재시험; 보안 검사 유지.
- Tor same-session disable와 기존 Remote RPC 실동작/장애복구 회귀 PASS. Pi 실제 backup context/4개Toridentity snapshot31항목 PASS. 배포파일32개 SHA 일치, manifest af1f412a1dadd6bec23ce027a43d9f72a0228a53153c3d6ddbe162d557c6051c. Pi backup/web 관리 서비스 갱신 후 Core/electrs/Tor/manager/policy/versions/web active 확인.
- Pi 원본 /root/jv-before-device-settings 및 /opt/justverify/web-device-previous 보존. 실제 owner 암호 변경 없음. 별도 시험 계정으로 Pi 모델/IP/OS 정보 및 desktop1200/mobile390px, 테마·언어·refresh/session·logout PASS. 두 브라우저 탭과 Pi 임시 웹/계정은 제거했고 VM fixture 원본 복원 완료. VM 실행은 functions session6201, 증거 .state/device-settings/.
- Pi Core31.1 mainnet blocks408969→412363 IBD=true, electrs는 Core 초기 동기화 대기. 이번 수정의 새 이미지 빌드/부팅, 전체 IBD·인덱싱 완료, 실제 모바일 지갑 및 기존 S4 최종 기준은 남아 있다. 상세 결과/실패 재시험/복구는 DEVICE_SETTINGS.md.

## 최신 재개 지점 — Pi 동기화 시작·로그인 유지·설정 UI (2026-09-12)

- 사용자6항목 실제 Pi 반영: `/session`으로 cookie 세션 복원(기존1시간/로그아웃 만료 유지), Electrs·버전 변경 명칭, 중복 browser 피어 메뉴 제거, version card hover/click/전환검토, boolean/network switches 및 수치/수수료 문자열 입력·기본/저장값·버전별 지원. `web/node_admin.py`, `web/static/settings.js`. 기존 native TUI/검증 API 유지.
- Pi Core 미시작 원인은 초기 노드 등록 누락. 새 빈 NVMe UUID·factory marker·owner를 확인한 기존 storage prepare→versions preview/apply→root check_initial 경로로 Core31.1 main/node 프로필 최초 등록. 기본 최초 로그인 흐름에도 같은 idempotent POST를 연결, 기존 active 선택·데이터는 변경하지 않음. 실제 IBD blocks0→29382→101959→250969 관측. 전체mainnet 동기화/index완료 아님.
- Pi 실제 재부팅 PASS: boot ID 변경, NVMe UUID/owner/profile/node-ready/active manifest SHA 동일, 재부팅전250969 tip이 재부팅후252303 체인의 같은 높이 조상으로 유지, peers2 및 Core/electrs/policy/manager/Tor/web active, HTTP justverify.local200. electrs는 Core IBD 후 준비를 확인하도록 표시하며 process active를 indexing완료로 간주하지 않음. `.state/pi5-install/settings-{before-reboot,after-reboot,reboot-result}.json`.
- 설치된21개 web파일 SHA와 소스 동일 PASS (web manifest digest d35deb0c4a0a5bd0fd69b5dddef9e02494543b250868e6ec5ba830a764b70ff3). Pi `/root/jv-before-settings-ui/web`에 이전웹 보존. 관리자암호 취득·변경 없음. Pi 임시시험웹/계정 삭제·중지 완료. 새설치이미지는 이 변경 미포함(NOT RUN).
- 실제 browser PASS: 별도 인증된 Pi loopback + VM regtest에서 login→reload 인증유지; Mempool toggle0→1→preview→apply→재시작→저장값재조회;31.1→23.2→31.1 실제버전변경 및 원래 체인 복귀. unselected27.2 card hover=true 및 별도 selected23.2 aria-pressed=true 실관측.1200/390px scrollWidth 동일, screenshots `.state/browser-ui/settings-{desktop,mobile,mobile-policy}.png`.
- 새 web API 실검증 + 전체 등록 Linux 회귀 PASS(exit0): auth/Origin/CSRF/schema/one-use token, 실제23.2↔31.1/설정재시작/uploadtarget RPC/maxconnections startup log/electrs높이, outgoing/incoming/resource/index, Tor handshake/onion RPC, TLS/QR, watch-only/PSBT권한, 중단 버전 복구. `.state/browser-ui/settings-integration-audit.log`. 원래 VM volume/profile/binaries/owner/catalog 복원 완료; bootstrap version service stopped. 현재 backup service prerequisite는 VM에 설치/active 상태로 유지.
- HTTP 세션·온보딩 및 HTTPS 보안 회귀 PASS. 실제 Pi QR API/랜·Tor payload 디지털 decode PASS. 초기 실패로그 보존: 오래된 VM 메뉴fixture·미설치 backup dependency·잘못된 testvenv·서비스 start-limit·동일버전/미다운로드판 요청·maxconnections RPC 필드 오해·오래된 catalog·80열 QR footer·fixture 누락 Python dependency를 원인별 수정. tests 삭제/QR assertions 축소 없음. `docs/evidence/browser-settings.json`.
- 추가 storage TLS/root inventory/RPC client 회귀 PASS `.state/browser-ui/settings-storage-api.log`; 실제 포맷 요청 없음. VM Core/electrs/web/storage active 및 원래 owner 없는 상태 복원 확인, 임시 브라우저/forward 정리 완료. 전체 S0–S4 완료 또는 배포 후보 판정 아님. 새이미지재빌드·Pi전체IBD/electrs index·실제모바일·24시간 및 기존 릴리스 게이트는 남아 있음. `.DS_Store` 보존.


## 최신 재개 지점 — 반응형 박스 UI·브라우저 QR 실검증 (2026-09-12)

- 사용자 스크린샷과 같은 깨짐을 실제 브라우저에서 재현: xterm 동적 스타일이 CSP style-src self로 차단되어 글꼴/색상/폭이 무너짐. styles만 inline 허용, scripts는 self 및 기존 인증/CSRF/Origin/고정 비권한TUI 유지. 브라우저 resize 때 SIGWINCH 추가. 단순 PTY 통과로 브라우저 정상 판정했던 이전 검증 공백 수정.
- 브라우저 메인은 동일한 실제 수집기 Snapshot의 인증+CSRF 보호 GET /dashboard로 만든 ANSI 스타일 반응형 박스. 데스크톱 2열/390px 모바일 독립 세로박스, 헤더/최근 블록 행/피어/수수료/실측 CPU·RAM meter. 설정용 실제 TUI는 그대로, native 작은 화면도 별도4박스 및 CPU 막대. 사용자 최신 요청으로 기존 차트금지 중 작은 자원막대 예외 명시(DECISIONS). 차트·가짜 블록/피어 없음.
- 지갑 연결 첫 화면은 Electrum 연결: 로컬 네트워크/Tor 탭, 주소·50002 TLS/50001 Tor TCP·인증서·상태 구분. 인증된 /electrum API, 기기에 생성된 주소/인증서 사용. 서비스 inactive이면 configured address와 연결대기 표시; backend electrs 활성도 함께 검사. 기존 native lan_endpoint 기본 active 요구 유지, browser의 읽기 전용 조회만 require_ready=False 허용.
- QR은 실제 matrix를 정수8px 모듈+quietzone으로 canvas 이미지 생성하고 PNG 저장. 실제 browser PNG 두 장 및 desktop/mobile screenshot QR를 zxingcpp로 읽어 payload SHA256 정확 일치 PASS. 카메라/지갑 import 성공과 구분. 증거 `.state/browser-ui/{api-evidence,browser-qr-evidence}.json`, 해당 PNG들, 공개요약 docs/evidence/responsive-ui.json.
- 테스트 PASS: cargo test --locked; tests/dashboard_live.py 실제 Core31.1 regtest/reorg/offline/120·80·42열; tests/web_lan_onboarding.py; tests/web_security.py; tests/web_dashboard_api.py (실제 Linux VM Core31.1/electrs0.11.1 수집기, auth/CSRF/crossOrigin/선택오류/logout/실제주소QR). 브라우저에서 처음 GET Origin 헤더가 제거되어 403 발생, 세션연결 CSRF 헤더로 수정 후 실제브라우저 통과. 시험서버 재시작 일시 접속실패도 있었으나 복구 후 검증.
- 실제 Pi5 바이너리 SHA256441ba4a6f15480599ae4656e4e699d8225c4140d57e8801801a8ac4b6a1ea347와 전체 web 적용. 원본 /root/jv-before-responsive-ui 보존. 사용자 관리자암호/설정/체인/지갑 데이터 보존, web/manager만 재시작. 별도 loopback 시험세션으로 Pi 실측 CPU/RAM/디스크·미설정 상태·LAN/Tor QR 화면 관측. 사용자 Safari 실제 justverify.local 메인도 읽기 전용 육안 확인 PASS(사용자 세션/암호 취득 없음). 인증된 별도 Safari 시험 흐름은 사용자 조작으로 중단되어 이를 추가 PASS로 세지 않음.
- Pi/VM 임시 jv-ui-review 서비스를 정지하고 테스트 자격증명 삭제; 로컬 독립 regtest/시험 웹/SSH forward 종료. 기존 VM Core/electrs 및 Pi web/manager active 유지. .DS_Store 보존.
- 남음: Pi Core/electrs 초기 설정·실제 연결(현재 inactive), 새 이미지 재빌드/부팅, 실제 휴대폰 카메라/지갑 연결 및 앞선 릴리스 필수 게이트. 화면 개선은 전체노드·릴리스 완료 아님. 새로운 이미지에는 이번 변경 미반영(NOT RUN).


## 최신 재개 지점 — 영상 기준 Bitcoin Core 중심 UI (2026-09-12)

- `src/dashboard.rs` 실제 Ratatui 메인: 노드 요약/최근 6블록/네트워크·mempool·수수료/피어 요약/시스템·서비스. 120열 다중 구역, 80·42열 단일 요약. 데이터 없음/오래된 수집/연결 실패 표시. 채굴 풀 추정이나 그래프/가짜 데이터 없음.
- 상위 메뉴 Bitcoin Core / 지갑 연결 / 기기 설정. 버전·정책·피어는 Core 하위, 저장장치·초기 설정/백업·복구/진단은 기기 설정 하위. 네이티브 S는 설정 메뉴, 그 안 S는 저장장치. 브라우저 F1–F10 전용 이동으로 입력 중인 설정에 문자 삽입 방지. 기존 실제 포맷/복구 시험의 경로 및 메인 복귀 표지만 변경; 보호·데이터 검증 assertions 유지. 이들 전체 장치 시험은 이번 변경에서 재실행하지 않음.
- 공식 Umbrel Bitcoin commit2fe07948f99e101dbee95ce34e5947a69c441ee4의 home/Header/Blocks와 LICENSE.md 직접 검토. PolyForm Noncommercial 소스·아이콘·3D 리소스 복사 없이 독립 구현. 사용자 2025 영상은 배치 참고. docs/UI_REDESIGN.md.
- 실제 Core31.1 격리 regtest + 수집기 + PTY 시험 PASS: 최근6개 연결된 헤더, 새 tip 갱신, invalidate 후 다른 branch 표시, 120/80/42열 및 리사이즈, 메뉴 이동, Core 종료 STALE. cargo test --locked PASS. HTTP onboarding 및 HTTPS 보안 기존 시험 PASS. 실제 Pi5 비권한 TUI/메뉴 이동 및 미설정 Core 표시 PASS. 증거 `.state/ui-reference/`, 공개 요약 `docs/evidence/dashboard-live.json`.
- Pi192.168.10.47의 바이너리/웹 정적 파일 적용, 수집기만 재시작. `/root/jv-before-dashboard` 이전 버전 보존. 관리자 등록 유지(/auth-status setup_required=false), 웹 서비스/노드 데이터·암호 변경 없음. 기존 열린 TUI 세션은 브라우저 새로고침/재로그인 필요.
- Pi의 Core/electrs는 아직 비활성: 이 UI 시험을 실기 노드 동기화 성공으로 간주하지 않는다. 신규 설치 이미지에는 새 화면 미반영(NOT RUN); 다음 빌드/이미지 부팅 시험과 실제 최초 노드 설정 이어가기. 전체 S0–S4/릴리스 완료 아님.


## 최신 재개 지점 — HTTP 최초 등록/로그인 UI 실기 적용

- 사용자 요구로 사설 LAN HTTP80에 실제 관리 UI 제공(HTTPS 강제 redirect 종료). `http://192.168.10.47/` 및 mDNS HTTP 경로. HTTPS443/외부 RPC TLS 유지. 최초 LAN 등록은 코드 없이 새 암호12자 이상+확인값으로 수행하며 초기등록/일반로그인 화면 분리. 관리자 등록 전임을 확인했고 사용자 암호를 임의 생성하거나 기존 관리자파일을 삭제하지 않았다.
- 실제 Pi5에 server.py/static3개/web systemd/owner_console 적용 및 서비스 재시작. 실제 브라우저 HTTP 페이지의 새 암호/확인/시작하기 화면과 레이아웃 확인. /auth-status setup_required=true/requires_code=false. 초기 단일 curl은 서비스 시작 직후 refused였으며 곧 재요청 성공; 실패 누락 없이 기록. 이전 잘못된 코드 시도 제한은 서비스 교체로 초기화됨. 변경 전 파일 /root/jv-web-before-http 보존.
- tests/web_lan_onboarding.py 실제 독립 HTTP/TLS 프로세스+고정 TUI WebSocket 시험 PASS: 확인값불일치400, crossOrigin403, 코드없는등록200, 중복등록409/기존암호보존, 로그인/로그아웃, 실제 TUIWS, 직접 HTTP RPC404, 잘못된암호401/429 Retry-After, 서버재시작후로그인. 기존 tests/web_security.py 실제HTTPS 회귀 PASS. 로그 .state/pi5-install/http-onboarding-test.log 및 https-regression.log.
- HTTP/HTTPS 세션 쿠키 이름 분리; HTTP는 private peer middleware+정확한 로컬 Host/Origin 검사, 웹 고정TUI/CSRF/암호hash/시도제한 유지. HTTP 전송 및 최초LAN등록자 소유권 모델의 사용자 지시 예외는 DECISIONS에 명시.
- 마지막 읽기 전용 확인에서 /auth-status가 setup_required=false로 바뀌었다. 작업 중 실제 기기 관리자 등록이 이루어진 상태이며 에이전트는 관리자 암호를 입력/변경하지 않았다.
- 다음: 실제 기기 관리자 등록 이후 실제 기기 노드 설정/TUI/Core·electrs·지갑 검증 이어가기. UI 등록 성공은 독립 시험 PASS이나 실제 기기 등록 상태는 마지막 확인에서 완료로 관측됨(사용자 암호/세션은 읽지 않음). compact 이미지에는 이 최신 UI가 아직 없으므로 향후 새 이미지 빌드/검증에 포함할 것. 전체 릴리스 완료 아님.

## 최신 재개 지점 — Pi5 SSH 암호 접속·재부팅/웹 접근 PASS, 경량 이미지 생성 완료 (부팅 미검증)

- 사용자 명시 지시로 SSH justverify 기본 계정을 shell=/bin/bash로 열고 사설 LAN 한정 암호 로그인을 설정했다. 실제 암호 로그인 및 실제 재부팅 후 재로그인 PASS. root 공개키 접속 유지/공개 IP passwordauth=no 확인. 최초 설정 marker로 사용자 변경 암호를 재설정하지 않는다. docs/evidence/pi5-ssh-default.json.
- 실기 Pi5 IP192.168.10.47, NVMe2TB data 확장/UUID등록/firstboot 성공, NTP yes, throttled0x0 확인. owner 미등록으로 Core/electrs 설정 전이며 전체 노드 정상 완료 아님.
- Safari 연결 실패 조사: HTTPS443 실제 서비스 동작, HTTP80 listener 없음. HTTP GET/HEAD를 고정 HTTPS 주소로302 안내하는 비권한 서비스를 추가하고 재부팅 후 유지 PASS. SSH로 얻은 기기 인증서를 명시 신뢰해 실제 mDNS https://justverify.local/ HTTP200 확인. 브라우저 인증서 최초 신뢰 사용자 절차는 남아 있다. 임의 Host로 redirect하지 않으며 HTTP에서 암호를 받지 않는다.
- 물리 콘솔 기본 폰트에서 한글 사각형 표시를 확인하여 ownership 안내를 ASCII로 바꾸고 서비스 재시작. 실제 TUI 본화면은 owner 등록 후 검증할 항목이다.
- 이미지 원인/조치: 원본 raw9.12GB와 compressed915.8MB를 구분. apt 목록/archives/pipcache 제거 및 root5GiB offline 축소/GPT data 재배치/mkfs factorydata, root/data fsck·GPT verify PASS. 새 raw6,444,548,096 bytes(약29%감소). 기존 실제 SSD는 축소하지 않았다. 신규 SSH/HTTP/console 파일을 private 시험 이미지에 반영했다. 압축 완료 exit0: `.state/pi5-install/justverify-pi5-compact-ssh.img.xz`. 원본 builder `.state/pi5-compact.img`. 압축798,050,496 bytes(기존915,813,560 대비12.9%감소), SHA25648fe35705c4abb23858ea63857adf0c455e911e63fc4a859f2cf64dd92b34ad5. xz -t PASS. actual boot 검증 필요. 새 이미지 부팅 NOT RUN, 배포 후보 아님. builder 여유544MB라 추가 복사 전 정리/호스트 보존 확인 필수.
- 빌더에 신규 SSH init/HTTP redirect 및 compact_factory_image→xz-6 경로 반영. 호스트 shell/Python syntax PASS. compact 실행 도중 기존 이미지/소스/증거 삭제 없음. 기존 dev15 resize 결함 원본은 참고 보존하되 새 설치에 사용하지 않는다.

## 최신 재개 지점 — resize 수정 이미지 재기록·검증 PASS

- 재연결된 같은 2TB RTL9210 disk6의 3개 파티션 offset/size/PARTUUID가 원본과 일치. diskutil verifyVolume bootfs fsck_msdos -n exit0. read-only 포함 mount 실패, sudo -n 인증 필요로 직접 매체 파일 수정 대신 기존 승인 범위의 Etcher 재기록 경로를 사용했다.
- 원본 private 이미지의 boot FAT를 Linux에서 mount해 cmdline의 유일한 `resize` 토큰 제거. fsck.fat -n PASS. 수정 이미지는 `.state/pi5-install/justverify-dev15-pi5-resizefix.img`, SHA256 `f2a6786673e477f339ca37462095c926fddc0ed113df47d8c3f5f7d831c32c23`. 부팅 파티션 밖 모든 바이트가 원본과 동일함을 대조 PASS. 원본 dev15와 이전 실패 증거는 불변 보존. 수정 이미지도 개별 소유권을 포함하므로 공개 배포 금지.
- Etcher 2.1.6 기록 및 읽기 검증 완료, GUI Flash Completed / 1 Successful target. 검증 생략 없음. 안전 추출 `diskutil eject /dev/disk6` PASS. 증거 docs/evidence/pi5-resizefix.json, private log .state/pi5-install/etcher-resizefix-result.json.
- 사용자 다음 조치: 전원이 꺼진 Pi5에 NVMe 연결, LAN/전원 연결 후 IP 제공. 수정 후 Pi5 실제 부팅은 NOT RUN. 이전 물리 부팅 FAIL을 보존하며 전체 정상작동 확인 완료 아님. 이후 scripts/pi5_inspect.py로 SSH 점검부터 진행.
- 재현 경로는 source25a7753의 build_single_disk.py 옵션 제거 및 verify-pi.sh 실제 boot cmdline 검사가 기준. 배포용 새 버전 전체 빌드/서명은 별도로 남아 있으며 기존 dev15 배포 이미지에는 resize 문제가 남아 있어 재사용 금지.

## 긴급 재개 지점 — Pi5 실제 부팅 FAIL, initramfs resize 옵션 수정 필요

- 사용자 실제 Pi5 사진에서 initramfs `Resizing root partition` → GPT `Fix/Ignore?` 입력 대기 확인. 매체 기록 검증 PASS와 실제 부팅 PASS는 별개이며 물리 부팅은 FAIL이다.
- 읽기 전용 Linux mount로 동일 이미지 cmdline 끝의 `resize` 및 실제 Raspberry Pi OS `scripts/local-premount/resize_early` 확인. 해당 스크립트는 ` resize` 인자가 있으면 parted를 비배치 모드로 호출하여 root p2를 디스크 끝까지 확장하려 한다. JustVerify p3 데이터 레이아웃과 충돌한다. `local-bottom/set_partuuid`도 같은 인자로 실행된다.
- `scripts/build_single_disk.py`에서 `resize` 인자를 제거하도록 수정. `image/verify-pi.sh`는 실제 boot 파티션도 읽기 전용 mount하여 single-os의 `resize` 잔존을 거부하도록 보강. Python compile/bash syntax PASS. 수정 이미지 실기 재시험은 NOT RUN.
- 이전 QEMU는 generic initrd 및 자체 `-append`를 사용하여 Pi 실제 cmdline/resize hook 경로를 실행하지 않았다. 이 검증 누락을 인정하며 기존 VM PASS를 실제 Pi 부팅 PASS로 사용하지 않는다.
- 다음 최소 사용자 조치: 현재 `Fix/Ignore?`에 응답하지 말고 Pi 전원을 끈 뒤 같은 NVMe를 Mac에 재연결. 에이전트가 매체 재식별 후 boot cmdline의 정확한 단일 `resize`만 제거하고 GPT/파티션 변경 여부도 읽기 전용 대조한다. 수정 후 원본/시험 이미지와 증거도 갱신하고 Pi 재부팅 확인. 전체 정상/최종 릴리스 완료 아님.

## 현재 재개 지점 — Pi5 시험용 SSD 기록·검증 PASS, 실제 부팅 대기

- 사용자 허용 대상 2TB GEIL RTL9210 USB SSD를 재연결 후 external physical `/dev/disk6`, 2,000,398,934,016 bytes로 재식별했다. A/B 없이 단일 OS + boot/root/data 3개 파티션 구성이다. 데이터 영역은 첫 부팅에 남은 NVMe 공간으로 확장한다.
- **balenaEtcher 2.1.6 raw IMG 재기록·read-back 검증 PASS:** GUI `Flash Completed!`, `1 Successful target`; 로그 successful=1/failed=0/errors=[]. raw 이미지 크기9,120,514,048 bytes, Etcher blockmapped 실제 기록3,142,582,272 bytes. Etcher가 기록 대상으로 선택한 블록의 검증이며 독립적인 전체 디스크 SHA256 검증으로 표현하지 않는다. `docs/evidence/pi5-media-flash.json`, private 원시 로그 `.state/pi5-install/etcher-raw-retry-result.json`.
- **안전 추출 PASS:** 검증 성공 후 `diskutil eject /dev/disk6` exit0. 사용자 다음 조치: NVMe를 전원이 꺼진 Pi5에 연결하고 유선 LAN·전원을 연결한 뒤 LAN IP 제공. Pi5 실제 부팅은 NOT RUN; 전체 완료 아님.
- 시험 이미지 `.state/pi5-install/justverify-dev15-pi5-test.img` SHA256 `fe1354b691df8989bce5bd40594877200ed8745cd00f806d517a0a11fc219d95`. 압축본 SHA256 `43f92961ba7dc72d3cf14575551396210cfcc26a21a446a9b1a54425f0a16b73`. 개인화 소유권 파일·SSH 공개키 포함, 개인키·공통 암호·SSH host key 없음. 공개 배포 금지. VM 2부팅·Tor onion·root SSH/암호 로그인 차단/host identity 유지 PASS (`pi-test-image-boot-retry.json`, `pi-test-image-ssh.json`). 초기 Tor timeout 기록은 보존한다.
- 첫 compressed 기록은 EVALIDATION checksum mismatch로 FAIL, 성공으로 변경하지 않는다. xz CRC 검사/추출 정상. Etcher 장치 검색도 응답하지 않아 안전 추출 후 사용자 물리 재연결 및 raw IMG 입력으로 해결했다. 두 조건이 함께 바뀌었으므로 압축/USB/SSD 중 단일 원인을 확정하지 않는다. `.state/pi5-install/etcher-first-failure.json` 보존.
- IP 수신 후 `scripts/pi5_inspect.py <LAN_IP>`로 root SSH 읽기 전용 첫 점검. SSH 개인키 `.state/pi5-install/id_ed25519`는 Git·이미지 제외. 이어서 실제 Pi 모델/EEPROM/NVMe 확장/firstboot/서비스/TUI/연결·재부팅 검증을 진행한다.
- 전체 S0–S4/최종 배포 후보 완료 아님. 백업 반출입·재설치 복원, 단일 OS 업데이트/실패 복구, 정책 전체 범위, OS 재현 빌드/고지 및 실기·모바일·24시간 검증이 남아 있다.

### 최신 검증 체크포인트 — dev15 단일 NVMe

- dev15 실제 **단일 가상 디스크** 최초 부팅30.872727초 및 재부팅32.556359초 PASS. 데이터 자동 확장/기기별 UUID/HTTPS 최초 등록/선택 Core31.1 regtest watch-only/electrs/Tor 실제 onion RPC/TLS/브라우저 TUI·NVMe 준비 안내/QR/설정·기기 신원 보존을 확인. `docs/evidence/image-dev15-single-probe.json`.
- 잘못된 data UUID를 주입한 별도 이미지에서 firstboot·Core/electrs/Tor/web/version/manager 차단 및 OS 영역으로 데이터 쓰기 없음 PASS. 시험에서 원래 UUID를 명시 복구한 뒤 실제 재부팅/동일 설정·Tor/TLS/지갑 연결 PASS(95.193440초). `docs/evidence/image-dev15-volume-fault.json`. 잘못된 볼륨을 제품이 자동 채택한 것이 아님.
- 읽기 전용 이미지 검증 PASS: `.state/dev15-frozen-offline-verification.log`, source e5c1737. 최초 live VM checkout 대상 검증은 catalog 차이로 FAIL(`.state/dev15-offline-verification.log`); 이미지 빌드에 사용한 고정 소스와 대조하여 모든 byte 검사를 그대로 통과함. 별도 generic kernel 시험이며 Pi EEPROM/NVMe 실기·NTP 동기화는 통과로 계산하지 않는다.
- 개발 번들 `dist/justverify-0.1.0-dev15-{rpi5-arm64.img.xz,source.tar.gz,manifest.json,SHA256SUMS,SHA256SUMS.asc}`. 이미지 SHA25636430b66111db10204a37cf524ab17575d1248c4061a0bd96ed9070debcf4e42. source e5c1737, Rust9cf2cd2 / SHA2567fbd04d086c734ff1ca215838935cc59d5ed1a3cbd3b1514577ea35293e8e2a1. 실험용 서명·5개 파일hash PASS `.state/dev15-bundle-verification.log`. 공개 배포 후보 아님.
- dev14의 firstboot 실패는 보존했다. dev15에서 resize 전에 전체 e2fsck -f -p 검사를 필수화하여 해결. A/B 코드 재도입 없음.
- 부팅한 `.state/vm/probe-dev15-*.img`에는 시험 신원이 있으므로 배포 금지. 원본 compressed image는 부팅하지 않았다. builder의 재생성 가능한 dev13 raw와 dev14 prepared 복사본만 공간 확보를 위해 정리했고 compressed 원본·시험 로그는 보존했다.
- **다음:** 소프트웨어의 백업 반출입·재설치 복원, 단일 OS 업데이트/실패 복구, 남은 정책 범위·재현 빌드/고지. 개별 root SSH와 headless 소유권 준비 및 VM 재부팅 검증은 완료했다. 실제 NVMe 기록 검증은 위 최신 체크포인트의 PASS이며 Pi5 IP는 미제공이다. 전체 S0–S4 완료 아님.

### 단일 NVMe 구현 및 검증 진행

- `scripts/factory_volume.py`: 이미지에 미리 만든 세 번째 데이터 파티션만 확장·UUID 개인화·마운트. 부팅 중 mkfs 없음. OS 한 벌과 동일 NVMe 데이터 영역이며 별도 상태 파티션 없음. 루트 파티션으로부터 실제 부팅 장치를 확인하고 GPT geometry/UUID/공장 marker를 검증한다. 기존 데이터 및 다른 디스크는 자동 포맷하지 않는다.
- 실제 Linux GPT/ext4/SIGKILL 복구 PASS: `.state/single-os-factory-volume.log`, `docs/evidence/single-os-factory-volume.json`. 기존 파일 거부·보존, 계획 UUID 유지, OS와 노드 sentinel 보존, 데이터 확장 확인. 실제 OS 부팅과 Pi 부팅 시험을 대신하지 않는다.
- `scripts/build_single_disk.py`로 dev13 pristine image에서 단일 OS dev14 조립 완료. 같은 방식이 기본 `image/build-pi.sh`에도 연결됨. 고정 프로필 검증과 storage API에 factory volume 등록 검증을 연결했다. dev14 실제 단일 디스크 부팅 FAIL: resize2fs가 전체 e2fsck 검사를 요구하여 firstboot와 종속 서비스가 차단됨. docs/evidence/image-dev14-single-probe.json. 실제 진단 이미지에서 e2fsck -f -p → resize2fs 성공을 확인했고 제품에 필수 전체 검사를 추가함. 새 dev15 최초/재부팅으로 재시험 예정.
- 개발용 dev14 시험은 UI 바이너리를 dev13과 동일하게 사용한다. 이후 storage 안내 변경은 다음 빌드에 반영하고 실행 검증해야 한다.

### 이전 진행 경과 (최신 지시가 우선)

- 사용자 Pi4/Pi5 보유 확인. Pi5 NVMe 시험 가능; 소프트웨어 이미지 준비 후 Mac에 NVMe 연결 요청 → balenaEtcher 기록 → 사용자가 Pi5에 장착하고 IP 제공 → 지정 장비 root 원격 시험 순서. 현재 실제 디스크 식별/연결/IP는 아직 받지 않았으며 기존 Umbrel 디스크에 쓰지 않았다.
- 백업 WIP 보존 사본: .state/pre-backup-hardening/. 선택된 버전 정책 파일 백업, canonical root 설정/데이터 UUID 검증, 관리자 재인증, 서비스 health 확인 뒤 commit 구현 중.
- 호스트 실제 GPG 형식/암호화 시험 PASS, Rust 정책 검증 6개 PASS. 실제 등록 VM 백업 시험 첫 실행 FAIL: active selection의 policy_file 필드를 검증기에서 누락. 기존 fixture 볼륨/설정 복원 PASS. canonical 네 필드 전체 대조로 수정 후 재시험 진행. 로그 .state/backup-production-audit.log. 통합 성공으로 계산하지 않는다.
- 남은 소프트웨어: 백업 내구성/중단 복구·UI, 전체 정책 의미 검증, 시스템 업데이트 실패 복구, 재현 빌드·릴리스 준비. 아직 NVMe 기록 요청 단계가 아니다.

### 이번 작업의 추가 검증 및 재개 지점

- 실제 등록 VM 백업 및 전체 후속 회귀 PASS: .state/backup-production-audit-retry.log. canonical active selection의 네 필드 검증으로 수정했다. 원래 VM 볼륨/설정 복원 PASS.
- 실제 복원 중 SIGKILL → 별도 복구 호출 → 이전 정책430/identity 복원 PASS: .state/backup-production-crash-audit.log. 건강 검사는 인증 Core RPC 및 Electrum TLS 헤더를 Core 해당 높이 해시와 대조. 물리 전원 차단/자동 부팅 복구는 아직 NOT RUN.
- 백업 ciphertext는 한 번 읽은 제한 크기 bytes로 digest·decrypt를 묶고, GPG --max-output=33554432, root restore openat/renameat 및 ancestor O_NOFOLLOW, rollback 각 파일 fsync 추가. 실제 GPG 호스트 공격/복원 시험 PASS .state/backup-hardening-crypto-4.log. Rust lib 10개 PASS .state/backup-ui-lib-tests.log.
- 실제 Unix API/systemd sandbox 백업 시험 PASS: .state/backup-production-systemd-audit.log. TUI 재인증 시험은 원래 시험 실행기 socket Path 타입, runuser 경로, noexec /run, 비밀 상태 디렉터리 및 비동기 화면 대기 문제를 수정하며 재시험 PASS(.state/backup-tui-reauth-retry10.log). 이전 실패 로그 보존.
- 재현 빌드: Linux ARM64 CPython3.13용 실제 wheel 11개를 다운로드하고 PyPI 공표 SHA256 대조, catalog/python-arm64.json 및 web/requirements.arm64.lock 생성. hash 강제 설치로 이미지 빌드 변경 중; 새 Linux venv 오프라인 hash 강제 설치 및 pip check PASS(.state/python-locked-install.log); 새 이미지 실행은 아직 NOT RUN. 기존 dev12 불변.

### 정책 행동 및 복구 시작 순서 — 다음 이미지 준비

- 32개 공식 검증 Core 릴리스에서 실제 서명 거래 정책 시험 PASS: docs/evidence/policy-semantics-matrix.json 및 policy-semantics/*.json. 30.0/30.1은 공식 철회된 바이너리라 BLOCKED 유지(미검증 우회 금지).
- OP_RETURN 단일/합산 경계, datacarrier, bare multisig, dust 임계값/zero, minrelay fee, persistmempool, mempoolexpiry, acceptnonstdtxn(regtest), blockmintxfee, 실제5MB 압력에서80개 서명 거래/저수수료 퇴출 검증. mempool 거부와 블록 합의 수용을 구분. 별도 실제 블록 조회로32버전의 확인 상태 재검증 PASS.
- mempool 보존 시험은 테스트 지갑을 unload한 뒤 확인하여 지갑 재접수와 mempool.dat 복원을 혼동하지 않는다. 크기90KB raw 거래는 CLI 인자 길이 제한 때문에 인증 HTTP RPC로 전달하도록 시험 실행기를 수정했다. 실패 로그 보존.
- 카탈로그 editable=false가 실제 UI/검증기 동작과 어긋나던 메타데이터를 정정하고10개 키의 구체적인 행동 증거를 연결했다. 전체 입력 범위·다른 네트워크·나머지 정책 의미를 완료로 표시하지 않았다. 공식Core 소스 commit32+철회2개는 catalog/core-source-commits.json에 고정.
- 중단 복구가 끝나기 전에 Core/웹이 시작되지 않도록 backup Type=notify 및 의존 서비스 Requires/After 적용. 실제 systemd 서비스 재시작으로 applying 저널 자동 복구·정책430·TLS Core/electrs 검증 PASS: .state/backup-startup-recovery-audit.log. 새 전체 이미지의 부팅은 아직 NOT RUN.
- 호스트에 같은 SHA256 이미지가 있는 것을 확인한 뒤 VM의 dev~dev8 압축 이미지 중복본과 사용하지 않는 dev12 준비 복사본만 정리했다. dist의 모든 원본과 호스트 private boot 시험 이미지는 보존. builder 여유10GB.
- 다음: 이 소스 체크포인트로 dev13 이미지 빌드/읽기 전용 검증/실제2회 VM 부팅. 이후 재설치 복원·암호화 백업 반출입, 남은 정책 범위, 단일 OS 업데이트/실패 복구, OS 의존성 재현 및 릴리스 서명. Pi5 NVMe 기록 요청은 아직 아니다.

### dev13 및 후속 작업 체크포인트

- dev13 pristine image/build-source/packages/manifest/SHA256SUMS/실험용 detached signature 저장. 이미지 SHA25605ec981ddc4dce5c5a689300b1447b57bafb217d7dda78ec63cae07124b5441b, source f9062ed / archiveSHA17c4934afd1a5a6dd1babf719190c9190a0efa254cc67bdd32e3330d05c44c20. Rust58ee499와 정확한 src/Cargo.lock 대조 후 재사용.
- dev13 실제 VM 최초/재부팅 PASS:61.815768s/24.836649s, docs/evidence/image-dev13-data-probe.json. root-firstboot/backup notify 의존성 및 Core/electrs/Tor/TLS/TUI/identity 복구 검증. NTP synchronized=no 및 Pi EEPROM/VSOCK 가상장비 제약을 기록, Pi 검증으로 세지 않음. private probe-dev13-data.img/image-data-16.qcow2는 배포 금지.
- 실험용 개발 서명키 fingerprint705D2C55D7BAFACB3683EE18329759FF93A854DF. 공개키 docs/keys/justverify-experimental.asc / catalog/release-signing.json. 개인키는 .state/release-signing (0700)에만 있으며 Git/이미지 제외. 재생성하지 말 것. 서명/파일hash PASS, 변조된 signed metadata·다른 fingerprint·신뢰키 부재 모두 거부 PASS. 기존 공개 배포 신뢰 identity라는 주장은 하지 않음.
- tests/policy_topology.py / policy_topology_matrix.py:32개 실제 Core PASS, 공식 철회2개 BLOCKED. 같은 부모/자식 graph 및 signed replacement를 유지한 채 limitancestor/count/size/descendant/cluster/incrementalfee/fullRBF 설정 변경으로 reject→accept를 검증. docs/evidence/policy-topology/*.json. 174개 버전별 정책 행에 실제 topology 보고서·hash·case를 연결했다. Core31에서 무시되는 ancestor/descendant 옵션에는 행동 검증 표시를 붙이지 않았다. 전체 범위 검증은 미완료로 유지.
- 새 빈 Cargo target으로 offline/locked release 재빌드 PASS: .state/rust-clean-rebuild-a.log 및 docs/evidence/rust-clean-rebuild.json. 동일 Debian ARM64 환경에서 이미지 바이너리와 SHA256 일치. 전체 OS/image byte 재현성과 독립 OS build는 아직 미완료.
- 다음 소프트웨어 작업은 그대로 계속: 남은 정책/범위, 재설치 및 백업 반출입, NVMe 단일 OS 설치와 업데이트/실패 복구, 재현 빌드·라이선스 고지 및 릴리스 준비. 아직 NVMe 연결/기록을 요청하지 않았다.

## 기존 dev12 산출물

산출물 저장 완료: dist/justverify-0.1.0-dev12-{rpi5-arm64.img.xz,source.tar.gz,manifest.json,SHA256SUMS}. 소스 archive1b779419020bd7af9cc08700c2382d37deb8224b, SHA256f5691ce5fb02cdbe574396df30ec5acfb9bc8189aefd6ba7b2a3f5a57886840e. 이미지·소스·패키지·manifest 전체 체크섬 및 git archive 바이트 대조 PASS. runtime 비밀정보/부팅 이미지/기존 백업 WIP 제외 확인. 미서명 개발 번들이며 전체 RC 미완료.

전체 S0–S4 배포 후보는 미완료다. 최신 개발 이미지 dev12는 빌드·읽기 전용 검증·실제 QEMU 최초 설치와 재부팅 PASS. 이미지 조립 a87289a, 동일 Rust 바이너리 빌드11c8419, 관측770b8e8. 이미지 SHA256902975da8186fb27f278eee46236e0ccb70e64c939a4a1c59dba7228551c2c46.

- 공식 소스 감사,34개 설정 대응표,32버전 설정/과거 블록 인덱싱, 실제 Tor 경로·37개 공개 RPC, 서명 regtest 및 공개 testnet4 검증은 UPSTREAM_AUDIT_REPORT_KO.md와 ACCEPTANCE.md를 따른다.
- 실제 이미지 두 번 부팅: image-dev12-data-probe.json. dev10/dev10b Tor 시간 초과는 실패로 보존; dev11/dev12 두 번 부팅은 PASS. Pi 펌웨어/실기/휴대폰을 대체하지 않는다.
- 공개 testnet4 전용 프로세스는 유지 중, PID는 .state/public-testnet4-audit/{process,electrs-process}.json에서 확인. --observe는 읽기 전용. 마지막 기록 높이152001/IBDfalse/Core-electrs-independent tip 일치, 자체 tx6 confirmations. 중복 지출 금지.
- 등록 시험 VM은 원래 볼륨/설정으로 복원했고 Core/electrs 활성. 이미지 시험 QEMU는 종료. 부팅한 private image/data15는 배포 금지.
- 다음 소프트웨어 작업: 전체 정책 의미 검증, BACKUP_REVIEW.md의 canonical root 설정·선택 데이터 보호를 먼저 해결한 뒤 기존 백업 WIP와 실제 복구, 원자적 시스템 업데이트/last-known-good, 재현 빌드·OS/Python/native 고지·신뢰한 서명.
- 외부 조건: 접근 가능한 Pi5/허용된 시험 미디어, 실제 휴대폰/별도 LAN/카메라, 대상24h 시험. 소프트웨어 미완료를 장비 탓으로 분류하지 않는다.
- 기존 백업 관련 사용자 변경 및 .DS_Store 보존. 미검증 WIP는 clean source archive/이미지에 포함하지 않았다. 자동 에이전트 재개 실행기는 구성하지 않았다.

## 이전 작업 기록 — 아래 항목은 당시 시점의 상태

2026-09-12: S0 진행, 전체 목표 S0–S4 유지. 배포 후보 완료 아님.

- 원본 AGENTS.md, PROJECT_BRIEF_KO.md, START_HERE_KO.md를 읽고 보존했다.
- 빈 구현 폴더에 Git 초기화. Rust scaffold, 격리 데이터 경계 및 서명 신뢰 정책 작성.
- macOS arm64, Rust 1.98.0, 여유 공간 약 390 GiB 확인.
- QEMU 11.1.1, GnuPG 2.5.22, Tor 0.4.9.12 설치 완료.
- 공식 Core 최신 31.1 확인. electrs API latest 응답 v0.11.1과 요구문서 0.12 계열 차이는 추가 검토 필요.
- Pi 5/휴대폰/삭제 허용 실디스크 미지정: 실기 검증 BLOCKED. 개발 및 VM 시험은 계속.

다음: 공식 바이너리 검증 및 regtest 기동, Rust 수집/TUI, ARM Linux VM 준비.

## 체크포인트 00:20 SGT

- Core 31.1 macOS/ARM Linux 바이너리 검증 PASS. 최초 missing trusted signer 실패 및 수정 근거 보존.
- Rust 기본 TUI/공유 RPC 데몬 구현, 3 단위시험 및 실제 regtest/PTTY(120×40)/Core 중단·재시작 PASS.
- 실제 HTTPS/WS 고정 TUI 브리지 보안시험 PASS. xterm 런타임 파일 포함. GUI 브라우저 조작은 아직 NOT RUN.
- electrs 0.11.1 소스 고정, libclang 실패 수정 후 빌드 PASS, 실제 인덱싱/scripthash/restart PASS.
- VM 부팅 PASS. Linux release build 진행, docs/evidence/linux-build.log 확인.
- Pi OS 2026-06-18 다운로드 `.cache/pi/base.img.xz.partial`; SHA256 검증 및 Linux 이미지 빌드 다음.
- 34개 Core 안정 릴리스 목록 생성. 전체 버전 도움말·소스·행동 matrix와 전환 구현은 남음.
- 상세 남은 항목은 ACCEPTANCE.md. 다음은 Linux 서비스/최소 이미지 빌드, Tor/Electrum 전파/QR, 설정 및 버전 전환.

최소 Pi 이미지 빌드 경로 `image/build-pi.sh` 추가: 검증 OS base→프로젝트 가상 파일 확장→서비스/실행파일 설치→identity 제거→압축/체크섬. 현재 개발 이미지이며 초기 설정/데이터 디스크 UI 및 최종 복구 기능 완성 전이다. 아직 실행 결과 NOT RUN.

## 체크포인트 00:44 SGT — 작업 계속, S4 완료 아님

### 추가 완료 및 증거
- ARM Linux Core matrix: 32개 공식 배포 버전 모두 signature/checksum/help/help-debug/start/RPC PASS. `core-matrix-summary.json`, 버전별 `core-matrix/*/result.json`.
- 30.0/30.1은 공식 wallet migration 버그로 binary 철회. `catalog/releases.json`에 UPSTREAM_WITHDRAWN 및 공식 공지 연결, 목록에서 삭제하지 않음.
- 32개 Core + electrs 0.11.1 조합 실제 indexing/history/broadcast/mempool/confirmation/restart PASS. `electrs-matrix-summary.json`.
- Pi OS 2026-06-18 기반 첫 **개발** 이미지 생성: 호스트 `dist/justverify-0.1.0-dev-rpi5-arm64.img.xz` (약 846MB). VM에도 `~/justverify/dist/` 존재.
- 이미지 `e2fsck -fn`, identity 부재, chroot ARM executable, Python/aiohttp, systemd-analyze verify PASS: `pi-image-verify-scratch.log`. Core help도 초기 경로 쓰기를 요구하여 이미지 자체는 RO + 별도 임시 bind data를 사용한 검사로 수정.
- Linux native services + 실제 loop data FS: Core/manager/web 시작, stop/stale/restart, data backing file 누락 차단, 실제 filesystem 여유 50MiB로 만들었을 때 Core 기동 거부, 공간 복구 후 data 보존 PASS: `linux-services-final.log`.
- VM reboot: boot id 변경, machine-id/SSH identity 유지, data mount 및 Core/manager/web 자동복구 PASS: `vm-reboot.json`.
- Tor 0.4.9.12 실제 회선 PASS, onion 실제 Electrum 조회 PASS: `tor-circuit.json`, `onion-electrum.json`.
- QR 디지털 roundtrip PASS: `qr-roundtrip.json`. 실제 휴대폰/앱은 별도 BLOCKED/NOT RUN.
- 정책 카탈로그 32개 버전 help/source 근거 및 adjacent diff 생성. **semantic range/behavior 검토 전이라 editable=false**. S3 전체 설정 완료 아님.
- Rust storage instance guard 구현/시험: network/version/electrs 별도 경로, 기존 unmarked 데이터/심볼릭 링크 거부, cross-version sentinel 보존. `cargo-test-storage.log`.
- Rust TUI/daemon에 Tor SOCKS 리스너 상태(회선 ready로 과장 안 함), electrs 실제 height 비교 상태, disk 수집, sat/vB 표시 추가. 3 기존 테스트 + storage 테스트 PASS. `regtest-services-run.log`, `web-security-services-run.log` 재검증 PASS.

### 현재 실행 환경/재개
- QEMU는 exec session 84719에서 실행 중이었음. 호스트 `scripts/vm_ssh.sh`로 현재 생존부터 확인. VM은 재부팅 후 Core/manager/web systemd 서비스가 실행 중(regtest, 제품 mainnet 아님).
- Mac Tor onion 전용 프로세스는 exec session 33565, SOCKS 127.0.0.1:19650. `.state/tor-test/onion-retry.log`. 실제 Core/electrs smoke 프로세스들은 finally에서 종료됨.
- Linux electrs 빌드 완료: VM `/home/builder/electrs/target/release/electrs` (0.11.1). Core별 verified binary: VM `/home/builder/core-matrix/<version>/bitcoin-<version>/bin`.
- Mac Core31.1: `.cache/core/31.1/arm64-apple-darwin/bitcoin-31.1/bin`; electrs `.cache/electrs-0.11.1/target/release/electrs`.
- 새 Rust service-status/storage 코드는 호스트에서 테스트했으며 **VM 바이너리 및 첫 Pi 개발 이미지는 이전 빌드**다. image/bitcoin.conf natpmp=0 및 systemd restart rate limit도 첫 이미지 이후 수정. 최종 image 재빌드 필수.
- VM sync는 scripts/vm_sync.sh (명시적 source 폴더만; .cache/.state/비밀정보 미전송). 현재 rust-toolchain.toml은 sync 목록에 빠져 있으므로 다음에 추가할 것.

### 다음 구현 순서 (승인 대기 없음)
1. S3 정책 semantic schema 검토 및 validation/diff/atomic apply/restart/health/설정 실패 복구 구현. `catalog/policy-*.json`은 초안이며 range=null을 검증완료로 바꾸면 안 됨. `src/storage.rs`는 보호 primitive만이며 서비스 version switch 전체 아님.
2. 실제 TUI S/M/V 설정 및 버전 전환 연결, 무동작 메뉴 없이 제공. 기본 화면 120×40/80×24/모바일 요약·모든 필드·no-color/리사이즈/UI 브라우저 시각검증.
3. firstboot owner token 전달(콘솔/headless), data disk 선택/기존 디스크 보존, hostname/IP fallback, LAN TLS, 개별 remote RPC gate/watch-only, 모바일 payload 및 QR 화면.
4. electrs/Tor systemd 제품 서비스, onion identity 영구보존, Tor-only fail-closed, 방화벽. 현재 image에 electrs 미포함, Tor package만 포함.
5. 암호화 backup/restore, signed atomic app/OS update 및 failure recovery, license/source notices, 고정 OS snapshot/wheel hashes, 최신 image 재빌드/재검증.
6. 실제 Pi5 부팅/NVMe/휴대폰 카메라 및 앱/24h Pi soak는 장비접근 없어 BLOCKED. 요구사항 제거 없이 사용자에게 필요한 최소 장비정보는 나머지 가능한 작업을 수행한 뒤 묶어서 보고.

S0~S4 전체 목표 유지. 전체완료/배포후보로 보고하지 말 것. 실행 중간에 생긴 실패 로그는 보존하고 새로운 근거 없이 같은 시험을 반복하지 말 것.

## 체크포인트 01:16 SGT — 정책/복구 및 상시 네트워크 서비스

- S3 정책 엔진/API/TUI 구현: 실제 격리 Core preflight→diff→일회성 receipt→원자 저장→고정 helper 재시작→RPC 확인. 입력 injection/미지원/ignored 옵션, network 및 범위 충돌, stale preview 거부. 정책별 semantic catalog/거래 수용·거부 전체 검증은 아직 미완료.
- 실제 Core31.1 적용/시작 실패 rollback/administrator SIGKILL 이후 복구 PASS (`policy-recovery-integration.log`). Linux API least-privilege 및 실제120×40 TUI edit/review/cancel/apply PASS (`linux-policy-api-ready.log`, `linux-policy-tui-vt-ready.log`).
- 실제 systemd policy service SIGKILL 후 자동 재시작, TUI interrupted 표시/R 복구 확인/Esc 취소/Enter 이전 설정 복구 PASS (`linux-policy-crash-tui-socket.log`). 시험 초기 readiness race 및 필수 socket 인자 누락 수정, 실패 로그 보존.
- VM의 Core/manager/web/policy/electrs/Tor 실제 서비스 실행 중. electrs 실제 generated regtest 블록 인덱싱/restart, Tor 별도 P2P/Electrum identity 재시작 보존 및 실제 onion Electrum 조회 PASS (`linux-network-services-test.log`). 현재 network는 regtest. RPC cookie/키는 비공개 경로 유지.
- `catalog/electrs.json`: 소스 commit/archive/Cargo.lock hash 및 tested ARM binary hash 고정. Mac 기존 모든 소스파일을 pinned archive와 비교 일치. 새환경 helper `scripts/build_electrs.py`는 작성/syntax 확인, 새 clean build 실행은 NOT RUN.
- image/build-pi.sh에 policy/electrs/Tor 및 catalog/고정 helper/sudoers 포함, firstboot 설정 디렉터리 생성, stock Tor disable. 패키징 시 Core/electrs tested hash 대조. 새 output tag로 기존 이미지 보존.
- **dev2 이미지 현재 빌드 중**: 호스트 exec session 48989, `docs/evidence/pi-image-dev2-build.log`. VM `/home/builder/justverify/dist/justverify-0.1.0-dev2-rpi5-arm64.img.xz` 예정. 빌드 완료부터 확인 후 최신 `image/verify-pi.sh`를 VM sync하여 검증할 것. 최신 verify는 component hashes/electrs/Tor/sudoers/키 부재 검사 추가. 기존 dev 이미지와 혼동 금지.
- Rust formatting + cargo test PASS (`policy-validation-final.log`), explicit real integration PASS. VM release latest hash a8d071ba647466f2a89a8ba88c379eae71cc9d64cc1517ae3fc551f71d684872. 이후 test 문구/스크립트 변경만 있으므로 source binary 관계 기록 시 확인.

다음: dev2 image 구조검증/산출물 복사 → 정책 semantic matrix와 version switch/일반설정 → 최초 소유권/headless/data disk UI → 모바일 TLS/RPC gate 및 QR/UI → 암호화 backup/update/signature/최종 image. 기존 Pi/휴대폰/24h 실기 BLOCKED는 유지하며 나머지 계속 수행. 완성된 배포 후보 아님.

### dev2 및 공통 정책 matrix 완료 체크포인트
- dev2 빌드/RO e2fsck/컴포넌트 hash/ARM Core·electrs·Tor·Python 실행/sudoers 및 systemd 검사 PASS (`pi-image-dev2-build.log`, `pi-image-dev2-verify.log`). 호스트 및 VM artifact SHA256 일치: `201ab81c02b111cb0a29a7022aa202a9ad4bb6e08a4d67786658af08ce296604`. 호스트 `dist/justverify-0.1.0-dev2-rpi5-arm64.img.xz` 전달 가능한 개발 산출물이며 Pi 부팅은 여전히 BLOCKED.
- `tests/policy_matrix.rs` explicit Linux ARM 실행: 32개 verified Core에서 8개 공통 정책(maxmempool/minrelay/incremental/dust/expiry/persist/datacarrier/size)을 넣은 실제 격리 기동 및 RPC 관측 PASS, 30.0/30.1 철회 상태 유지. `policy-matrix-run.log`, `policy-matrix-summary.json`. 이 시험은 각 정책의 실제 거래 수용·거부 동작 전체를 검증한 것이 아니다.
- session48989(build),21044(verify),9069(copy),41003(matrix)는 완료. VM 상시 서비스만 유지. 다음은 전체 정책 semantic/behavior 및 Core version switch/일반설정 구현이다.

## 체크포인트 — 버전 전환 엔진 및 실제 복구 통과

이전 goal turn은 정책/이미지 빌드·검증으로 실제 progress였다. 이번에도 실제 구현/실행 증거를 추가했으며 전체 목표와 BLOCKED 실기 항목은 변경하지 않는다.

- `src/versions.rs` 신규: verified binary/별도 data 및 index/버전별 policy, 실제 preflight preview, revision 및 lock, durable selector/journal, 실패 및 강제 종료 후 이전 전용 profile 복구. active data 유실 시 빈 체인 재생성 거부 및 root inode/device 변경 차단.
- 실제 Linux Core31.1↔22.0/electrs0.11.1 전환 PASS. 31.1의 생성 블록과 electrs height 보존; 22.0은 먼저 높이0 확인 후 테스트 블록으로 동기화. target startup 실제 실패 → 이전 profile 복구 PASS.
- 별도 전환 프로세스 실제 SIGKILL + target binary 경로 유실 → 이전 verified binary/data/index 복구 PASS. `docs/evidence/version-transition-recovery-final.log`, `version-transition.json`. 실패 로그 보존, test fixture 수정 이유 DECISIONS/TEST_RESULTS 기록.
- `cargo test --locked`는 `version-unit-final.log`, explicit integration은 위 별도 명령으로 실행. `src/policy.rs`의 atomic helper를 crate 내부 공유하도록만 변경했다.
- 현재 기능은 **엔진/실제 프로세스 시험 단계**다. 상시 VM systemd profile은 계속 기존 regtest31.1이며 TUI V/API에 아직 연결하지 않았다. dev2 image도 새 version engine 전 상태다. 전체 S3/S4 완료 아님.
- 다음 구체 작업: 비권한 version service + 좁은 root profile helper로 Core/electrs/manager/policy를 함께 전환; 정책/버전 작업 직렬화; TUI V 기본 major 최신 patch/확장 이전patch/지원상태/별도경로 preview; official fetch/signature 검증 다운로드 연결. 오래된 data 경로를 묵시적으로 adopt/move하지 말 것.
- 이후 전체 policy semantic/behavior, 일반설정, onboarding/headless/data disk, 모바일/TLS/RPC/QR, backup/update/signature/최종 image 및 기존 실기 gate를 계속 수행.

## 체크포인트 — 운영 버전 API/TUI PASS, 전체 목표 계속

- 이전 goal turn은 version engine/실제 Core/electrs 전환·강제종료 복구의 progress였다. 이번에는 그 엔진을 실제 systemd root bridge, 비권한 API 및 TUI V에 연결했다.
- `src/version_service.rs`, `src/version_ui.rs`, `scripts/profile_helper.py`, `image/systemd/justverify-versions.service`, `image/versions.json` 신규. 실제 help 기반 runtime option catalog 생성. 정책/버전 mutate API 공통 operation lock 적용.
- 실제 VM root helper 및 비권한 API, PTY V→N network→review→Esc 취소/Enter 적용,31.1→22.0→31.1, 일회성 token/extra field 거부/원본 profile 복원 PASS. `linux-version-tui-bootstrap-guard.log`. 등록되지 않은 profile을 운영 기본에서 덮어 바꾸지 않는 guard PASS (`version-registration-guard.log`). 정책 API shared-lock regression PASS.
- 실패 원인 2개 수정: 같은network에서도 Tor restart하던 것→P2P target 변경 시만 restart. ProtectSystem가 sudo root helper에 상속되어 /etc쓰기 거부→고정 root-owned 경로2개 writable mount 예외(일반 user 파일 권한은 root-only 유지).
- VM 최신 binary는 이 코드이며 상시 Core/manager/web/policy/electrs/Tor는 기존 regtest31.1 원본 profile로 복원했다. **versions service는 stopped**. `/opt/justverify/versions/31.1` 및 `22.0` verified binaries, `/srv/justverify/data/instances` 시험 data는 기존 `/srv/justverify/data/core`와 별도로 보존. `/var/lib/justverify/versions` active selector는 시험 전 상태(None)로 복원. 알려진 VM fixture만 installer가 allow_initial_selection=true 설정, 제품 기본 false.
- **dev2 이미지는 이전 checkpoint이며 이번 API/UI/helper가 아직 반영되지 않았다.** image build가 service glob을 복사하므로 다음 이미지 전에 versions config/helper/sudoers/baseline registration을 firstboot와 함께 제대로 통합해야 한다. 단순 enable하면 안 된다.
- 다음 필수 작업: official fetch/signature pipeline을 version API에 연결하여 missing artifact 다운로드; firstboot/onboarding의 최초 baseline 등록(기존 data 묵시적 adopt/move 금지); TUI version recovery/진행 상태와 network-switch 통합검증. 그 뒤 전체 policy semantic/behavior, 일반설정, 모바일/RPC/QR, backup/update/signature, 최종 image 및 실기 gates 계속.
- 긴 Core shutdown/IBD에서 동기 API 요청 timeout과 진행 상태 표시도 제품 수준으로 개선 필요. 현재 committed는 profile/프로세스 시작이며 전체 sync 완료가 아니다. 상세 미완료는 ACCEPTANCE/DECISIONS와 함께 확인.

## 체크포인트 — 운영 다운로드/서명/설치 및 TUI D 통과

- 이전 turn은 native version API/TUI의 실제 progress였다. 이번에는 missing artifact의 공식 다운로드를 background API와 TUI D에 연결했다. `src/download.rs`, `scripts/install_core.py`, fetch_core cache/evidence 분리 및 file lock. 고정 version만 입력, 1작업/600초 fetch 상한, durable 단계 상태, root installer의 실행파일 hash 재검증 및 atomic 저장.
- 실제 Core23.2 official download+signature+checksum+install+isolated preflight PASS (`linux-download-accessible.log`). 최초 root mkdir700 접근 문제→755 명시 후 재검증 성공. 처음에는 VM gpg 미설치→gnupg2.4.7 실제 설치. 원인/실패 evidence 모두 보존.
- 실제 modified SHA256SUMS GPG거부, invalid staged executable privileged installer거부, 기존설치보존, 원본복원후성공 PASS (`linux-download-rejection.log`). PTY V/P/23.2선택/D 및 완료표시 PASS (`linux-download-tui.log`). Rust checks PASS.
- VM `/opt/justverify/versions/23.2/.../bitcoind`에 verified executable 추가. private cache `/var/lib/justverify/downloads`, evidence 하위 JSON, private job log `/var/lib/justverify/versions/download.log`. VM Core/electrs/Tor/policy 정상 active, version service는 시험 후 inactive. 원본 regtest31.1 profile 보존. API fixture 초기등록 allowance는 기존과 동일하게 VM 한정.
- dev2 이미지는 여전히 이전 구현이다. 다음 이미지 조립 전에 version/download 서비스, helpers/sudoers/GPG, writable dirs, **onboarding 최초 baseline 등록**을 함께 통합해야 한다. service glob만 복사하고 enable해서 완료로 계산하지 말 것.
- 다음 최우선: 최초 소유권 전달/console·headless 경로, data disk UI/기존디스크보호, 최초 network/version 선택과 baseline selector 등록. 이후 version recovery UI/장시간 진행 상태, 전체 policy semantic/behavior 및 일반 설정, 모바일/RPC/QR, backup/update/signature/최종 image/실기 gates. 전체 S0–S4 목표 유지, 아직 배포후보 완료 아님.

## 체크포인트 — 초기 소유권/첫 TLS 신뢰 및 콘솔 흐름

- 이전 turn은 공식 download/검증/설치/TUI D의 progress였다. 이번에는 owner_file→firstboot consumption→TLS proof→admin claim→console TUI 전환을 구현하고 실제 TLS/VM PTY로 검증했다.
- `scripts/prepare_owner.py`, `verify_pairing.py`, `owner_console.py`, `image/systemd/justverify-console.service` 신규. web_identity를 재실행/부분생성 복구에 대응하도록 정리; claimed identity는 자동교체 거부. firstboot boot owner파일 private import/삭제/sync, web admin 저장 fsync 보강.
- Headless protocol 실제TLS/wrong-owner/different-TLS proof replay/verifiedTLS claim/등록후proof404/secretlog부재 PASS (`headless-pairing-durable.log`). 기존websecurity regression PASS (`web-pairing-durable.log`).
- VM 실제firstboot.sh 실행/파일소비/재실행identity유지/콘솔Enter전비표시/소유권등록후fixedTUI/shell없는종료 PASS (`linux-owner-firstboot-durable.log`). 초기PTYdimensions누락을120×40으로수정하여통과. 원래VMwebidentity/admin/profile은 복원되어있다. 임시ownersecret은 .state 또는테스트중privateVM디렉터리만사용했고로그/증거/Git에넣지않았다.
- imagebuilder는 owner_console 설치/enable/gettytty1disable까지 반영했으나 **새 이미지 빌드는 아직 미실행**. 현재 전달 가능한 dev2는 이전 checkpoint다. 실제Pi첫부팅/콘솔/브라우저인증서GUI 검증은 완료가아니다.
- 개발 headless 확인 도구는 CLI다. 일반 사용자용 준비 GUI/브라우저 신뢰 절차, 데이터 디스크 선택/보존/초기 version+network baseline 등록은 다음 핵심 구현이다. 소유권만으로 노드 설치가 끝난 것으로 표시하지 말 것. firstboot/node service 시작 순서도 초기등록이 끝나기 전 동기화를 시작하지 않도록 연결해야 한다.
- 이후 전체policy semantic/behavior 및일반설정, 모바일/RPC/QR, backup/update/signature,최종image/장비gate를 계속 수행한다. 전체목표유지, S4/배포후보완료 아님.

## 체크포인트 — 데이터 디스크 inventory/설치 화면

- 이전 goal turn은 소유권/first-TLS/콘솔 흐름의 실제 progress였다. 이번에는 read-only lsblk inventory와 TUI S의 장치 검토 화면을 구현했다.
- `scripts/disk_inventory.py`: system backing/root/boot 보호, read-only/현재data/기타mount/중복UUID/nested-use 구분, model/serial/WWN/partitionUUID 및 identity digest, 제어문자 제거. 같은 NVMe의 별도 data partition은 개별검토 대상으로 유지하여 NVMe 직접부팅 범위를 막지 않는다. FSTYPE 없음은 빈디스크가 아니므로 signature scan 필요 상태로 표시.
- 실제VM inventory/fstab·mountinfo무변경 PASS (`linux-disk-inventory-final.log`), topology경계단위 PASS (`disk-inventory-unit.log`), 실제PTY S분류표시/Esc복귀 PASS (`linux-storage-tui.log`). 물리디스크에는 쓰지 않았다.
- 새 release 빌드는 VM `~/justverify/target/release/justverify`와 시험용 `/tmp/jv-storage-tui`에 있다. 기존 서비스binary는 이번 storage화면 전 상태다. `disk_inventory.py`만 `/opt/justverify/scripts/`에 설치했다. imagebuilder의 script 복사목록에는 추가했으나 새image미빌드.
- **S 화면은 읽기전용이며 실제 disk provisioning/profile 등록 미완료**. 다음은 privileged read-only blkid/wipefs signature scan 및 contents review → 검증된 장치 identity에 묶인 선택/confirmation → 가상디스크에서만 format/mount/fstab 및 실패복구시험 → owner확인뒤 최초version/network baseline등록과 startup gating. 기존/물리disk는 지정·허용없이 변경하지 말 것.
- headless 일반GUI 및 실제브라우저 신뢰UI, 전체policy semantic/behavior/일반설정, 모바일/RPC/QR, backup/update/signature, 최종image/실기gate 계속. 전체 목표 및 미완료 상태 유지.

## 체크포인트 — 실제 signature/content review와 전용 provisioning 매체

- 이전 turn은 inventory/TUI S의 progress였다. 이번에는 `storage_probe.py` root read-only helper와 실제 blank/ext4 content review를 구현/검증했다. 모든 scan은 identity재검증, fixed no-act probe, 기존내용보존. readonly ext4 mount는 ro/noload/nodev/nosuid/noexec 및 fd/device 대조.
- `linux-storage-content-review.log`: 실제 프로젝트 loop fixture blank/ext4/기존파일 검토, 전체bytes hash불변, stale/system거부 PASS. production format은 아직 구현하지 않았다.
- 이후 실제format/mount시험을 위해 새 host `.state/vm/provision-test.qcow2` 2GiB 생성. `scripts/vm_start.sh`가 이 파일이 있을 때만 serial JUSTVERIFY_TEST_DATA의 virtio disk를 추가한다. 기존VM정상종료확인후재시작했고 SSH 및 Core/electrs/Tor/web active 확인. **현재 QEMU exec session32689**.
- 새 disk 때문에 kernel이름변경: test disk가현재vda, rootdisk는vdb, seed는vdc다. 절대로이이름을 format대상으로 하드코딩하지말고 serial/size/identity/currentmount 재확인. `provision-target-scan.log`는새2GiB매체의blank-signature분류PASS. 이disk는아직미포맷이다. root/data는보존복구됐으며고정rootUUID부팅은정상.
- 다음: persistent volume provisioning plan/명시적 confirmation/직전 signature+identity 재검증→이전용 test disk에서만실제format/mount/fstab 및중단복구→TUI S owner-authenticated selection→첫version/network baseline등록과기동gate. 실제device는사용자지정·허용없이변경하지말것.
- helper/API연결과새image는미완료. 기존headlessGUI/browsertrust, 전체policy/일반설정, 모바일/RPC/QR, backup/update/signature, 최종image/장비gate도유지한다.

## 체크포인트 — 실제 초기 volume format/중단복구/reboot

- `scripts/volume_setup.py` 내부 engine 구현: stable device/scan/fstab/destination에 묶인 persistent preview, exact erasure confirmation, 한번만 format, ext4 UUID/fsck 검증 복구, mount/instances ownership/atomic fstab. 기존 data destination 또는 fstab target은 거부. **아직 owner API/TUI와 연결되지 않았으며 production root CLI도 없다.**
- 새 프로젝트 전용 2GiB serial JUSTVERIFY_TEST_DATA에서 actual mkfs→SIGKILL→재실행format거부→readonlyfsck/UUID/mount/fstab recovery PASS (`.state/linux-volume-setup.log`). mounted phase replay/idempotentfstab/unmount후remount PASS. mounted phase replay는 state injection이며 실제kill로오인하지말것.
- real VM fstab에 이시험UUID와별도mount만 일시추가→proof저장→reboot→자동mount/proof보존 PASS (`.state/linux-volume-reboot.log`). 이후 시험mount해제, 원래fstab정확복원. Core/electrs/web/justverify-tor active, 기존data mount보존. 기본Debian tor@default는사용unit이아님.
- 전용disk는 이제 ext4다. VMfixture `/var/tmp/jv-volume-dcq9ed7o`에 state/fstab/proof볼륨이 남는다. destructive시험은 signature없는새projectdisk만허용하도록만들었고같은disk자동재포맷을거부한다. 후속수정에서추가한 plan destination/fstab-path binding은Pythoncompile만검증했으며 다음비파괴 regression으로검증필요.
- 다음: engine guard/중단단계추가검토 및비파괴regression → owner-authenticated narrow API/TUI S 확인화면 → 첫version/network baseline과startupgate → 새image통합검증. 이후headlessGUI/browsertrust, 전체policy/일반설정, 모바일RPC/QR, backup/update/signature 및실제Pi/mobile gate유지. 전체목표미완료.
- 추가 비파괴 regression 완료: 변경된 destination으로 apply/recover 모두 device access 전거부, 올바른 destination/fstab-path로 기존UUID복구·reboot-proof보존 PASS (`.state/linux-volume-destination-guard.log`). 시험fixture plan에새fstab-path필드를명시적으로추가했으며 production state migration이아니다.

## 체크포인트 — owner-authenticated storage API

- 이전 turn은 실제volume format/SIGKILL/reboot의 progress. 이번에는 root narrow Unix `storage_service.py`, systemd unit, 웹 `/storage` 인증·Origin·CSRF·strict schema 연결을 구현했다.
- root plans 기본위치를 `/var/lib/justverify-storage`로변경(root:root0700). 기존 `/var/lib/justverify`가 justverify소유라 root journal parent로부적절함을 실제stat로확인해수정. productionrootAPI는 fixeddefaultpaths, noargv, peercredentials, owner등록확인; 공개plan에fstab내용없음.
- `tests/linux_storage_api.py` 실제TLS→rootUnixAPI inventory/systempreview거부 및 unauth/CSRF/foreignOrigin/extrafield/unrelateduid/unclaimed거부 PASS (`.state/linux-storage-api.log`). 초기실패는원래VMowner미등록상태의정상거부였으며별도ownerfixture로분리. 시험은원래storageunit을잠시멈추고복원하며apply/format을호출하지않는다.
- VM `/opt/justverify/scripts/`에 storage 관련4개script 설치, unit `/etc/systemd/system/justverify-storage.service` active (아직enable안함). host와동일mountnamespace확인. 웹운영process는이전server로유지되고시험은별도TLSprocess였다. imagebuilderscript목록과enable추가했지만새image미빌드.
- 다음: TUI S에서장치선택/계획내용/정확확인문구/중단복구표시를연결하고실제owner API성공경로를새전용fixture로검증 → 첫version/network baseline등록·startupgate. 기존read-only S와신규API만으로설치완료아님. 나머지headlessGUI/browsertrust/전체policy/모바일/backup/update/image/physical gates유지.
- 기존실제TLS/WebSocket/TUI/session regression도 PASS (`.state/web-storage-regression.log`), Pythoncompile 및imagebuilder shellsyntax PASS. 성공한검증은추가변경영향이있을때만반복할것.

## 체크포인트 — TUI S 선택/확인/복구

- 이전 goal turn은 owner storage API/rootunit 실제TLS검증의 progress. 이번에는 `src/storage_ui.rs`로 TUI S의장치선택→계획→정확삭제문구확인, savedplan recovery review/cancel/execute 및background요청을구현했다. 기존매draw Pythoninventory실행을제거하고인증rootAPI로연결.
- rootinventory에민감fstab제외한savedplans추가; volumeengine은다른중단작업존재시새preview/apply거부. 잘못된확인문구/Esc/systemdevice 요청미발생 단위 PASS (`.state/storage-ui-guards.log`).
- hostbuild와ARMVMreleasebuild PASS. 실제PTY→rootAPI 장치표시/system보호/recoveryreview취소/실제UUID마운트복구·reboot-proof보존 PASS (`.state/linux-storage-tui-owner.log`). 테스트는기존전용volumejournal에formatted상태를재현하며새format/SIGKILL은아니다. 초기연결실패는fixtureAPI readiness확인추가후해결. 원래storageunit복원,시험volumeunmount완료.
- VM release는 `~/justverify/target/release/justverify` 및 `/tmp/jv-storage-tui`; 운영binary는아직이전버전. root storage_service/volume_setup은opt에설치·unitrestart. ownerfixture는시험끝삭제. 원래owner는여전히미등록이므로운영rootAPI거부는정상.
- 다음: 새로운전용매체에서 TUI preview/정확문구/apply 실제format 전체경로 검증, 화면폭80x24검토 → 최초version/network baseline등록과startupgate. S화면volume완료와노드프로필완료는분리표시. 새image및physicalPi/mobile,headlessGUI,전체policy/일반설정,backup/update 등의남은범위유지.
- savedplans API변경후 actualTLS/API 인증경계 regression PASS (`.state/linux-storage-api-plans.log`)。원래 service active 복원 완료.

## 체크포인트 — 80×24 TUI 실제 신규format 전체경로

- 이전turn은TUIselection/recovery의progress. 이번에는새프로젝트QCOW2 `.state/vm/provision-ui-test.qcow2` 2GiB를추가하고실제TUI확인→rootAPI→mkfs→UUIDmount/fstab까지시험했다.
- 기존QEMUpid28722 정상종료확인후재시작. **현재live QEMU exec session2746**, 부팅로그 `.state/vm/ui-provision-boot.log`. `scripts/vm_start.sh`는두번째testdisk존재시에만 serial JUSTVERIFY_UI_TEST로추가한다. 첫번째시험volume도보존. 커널device이름은고정하지말것.
- `tests/linux_storage_tui_format.py` 실제PTY 80×24 확인문구/잘못된입력/취소시signature불변 PASS; 정확문구입력후실제format/UUIDmount/instances/fixturefstabcommit PASS (`.state/linux-storage-tui-format.log`). 기존fstab/data보존검증. 이시험은별도owner-presencefixture이며TLS등록증거는앞선API시험과구분.
- 두번째disk는이제ext4/unmounted/REVIEW_EXISTING. 자동재포맷/테스트무작정재실행금지. VMfixture `/var/tmp/jv-ui-format-2afymm60`에state/fstab/proof보존. 기존data/Core/electrs/Tor/web/storage active확인 (`.state/ui-format-final-state.log`).
- **다음핵심: 최초version/network baseline등록과startupgate.** 현재production versions config의 allow_initial_selection은false로기존미등록data보호. root가발급한volume marker/UUID/empty instances와owner등록을검증하는정상초기경로를연결해야한다. firstboot에서기존기본Core를즉시시작하는흐름을검토하고등록이전동기화를막아야한다. 단순flagtrue로legacydata보호를해제하지말것.
- 새이미지는미빌드. headless일반GUI/실제browsertrust/전체policy·일반설정/모바일RPC/QR/backup/update/signature 및실제Pi/mobile/soak gates 계속남음. S4완료아님.

## 체크포인트 — 정상 최초profile 등록 eligibility

- 이전turn은새2GiB가상disk TUIformat전체경로progress. 이번에는 `profile_helper.py` fixed `check_initial` action과 versionAPI 첫preview/apply에서의실제rootguard호출을구현했다. test-only allow_initial_selection 기본false유지.
- rootguard는owner등록형식/mount/root-controlledmarker·state/실제findmntUUID/committedvolumejournal/중단없음/기본layout/emptyinstances검증. 추가파일·기존instances는보존거부. checkaction은services/config를변경하지않음.
- 실제JUSTVERIFY_UI_TEST 볼륨에서직접guard eligibility/extra파일/기존instance/wrongUUID/writablemarker/unclaimed/interrupted/unmounted거부 PASS (`.state/linux-initial-volume.log`). 시험용proof는다른filesystem으로보존이동했다가SHA256일치복원;volume다시unmount. 최초EXDEV는시험move를cross-filesystem지원으로수정하여해결. owner는별도metadatafixture이며실제TLS등록증거와구분.
- hostbuild PASS, ARMVMreleasebuild결과 `.state/initial-volume-linux-build.log`. 새helper와binary는운영opt에아직미설치. VM운영Core/data/owner프로필유지. **이변경만으로최초nodeprofile통합성공은아님**.
- 다음: 신규volume의firstversionpreview/apply를productionguard로실제실행·Core/electrs연결검증하고, firstboot기존core/electrs디렉터리자동생성·즉시기동을초기등록gate로대체. storagecommit뒤versions서비스기동과rootcontrolledstartup marker/복구순서검토. 기존data무등록상태의자동adoption금지.
- 전체S0–S4 및새image/physicalPi/mobile/headlessGUI/전체policy/backup/update 등미완료범위유지.

## 체크포인트 — 최초profile 실제 Core/electrs통합 및 cold-start수정

- 이전turn은initialvolumeguard구현/직접시험progress. 이번에는 `tests/linux_initial_profile.py`로productiondatapath에전용testvolume을일시mount하고실제versionAPI/sudo/check_initial/preview/apply/Core/electrs를검증했다. allow_initial_selection=false유지. owner는격리된metadatafixture(별도실제TLS등록증거와구분).
- 최초preview후instances변경시apply거부/보존 PASS. 최초apply/CoreRPC까지성공했으나electrs가cookie생성전기동하여실제실패를발견 (`.state/linux-initial-profile.log`). `wait_core_rpc.py` unprivilegedauthenticatedRPC readiness를electrs ExecStartPre에추가하고재시험.
- 수정후 productionfirstpreview/apply→Core31.1regtest→실제블록1생성→electrsheight1 PASS (`.state/linux-initial-profile-final.log`). 이전시도testinstances는 `/var/tmp/jv-initial-profile-rzh8imgo/previous-test-instances`에보존후신규registration재시험했으며format/data삭제없음. 시험backupmanifest는같은dir와 `/var/tmp/jv-initial-profile-uxlqiolq`에보존.
- 원래dataUUID/config/roothelper/Rustbinary/owner복원,versionAPI stopped. 이후RPC-startupfix인electrsunit/helper만VM에설치하여기존nodeheight2/서비스active확인 (`.state/electrs-rpc-startup-restored.log`). 새Rust/helper initialguard는현재운영opt에서다시이전버전이며source/releasebuild에있다.
- 전용UItestvolume에는이제실제regtestinstances가있으므로빈volumeeligibility/TUIformat시험을그대로재실행하지말것. node기동증거보존. Pythoncompile/imagebuilder shellsyntax PASS.
- 다음: 정상설치기동순서 완성. storagecommit뒤version서비스활성화, rootcontrolled등록완료gate, firstboot의legacycore/electrs디렉터리생성/즉시기동제거, TUI최초등록안내,등록후재부팅·복구시험. 새imageBuilder는새unit/helper포함하지만전체integration미완료.
- S4전체완료아님. 새image/실제Pi/mobile/soak/headlessGUI/전체policy·일반설정/backup/update/signature등나머지범위유지.

## 체크포인트 — 등록된profile 기동gate

- 이전turn은최초Core/electrs통합/cookiecoldstart수정progress. 이번에는 `node_ready.py`와rootactivate발급 `node-ready.json`, Core/electrs/policy unit의등록조건/ExecStartPre를구현했다. UUID/instance/binarySHA/configSHA/active선택/실제디렉터리검증후에만시작. manager/web는설치화면표시를위해gate밖유지.
- firstboot의mount만보고legacycore/electrs생성하는코드를제거, privateversions/downloads state준비로대체. 기존node data삭제/자동adoption없음.
- 실제systemd에서등록전3서비스inactive, 정상등록후Core/electrsheight1, 잘못된UUID는CorePID생성전실패,marker복원후기동 PASS (`.state/linux-registration-startup.log`). testbackup `/var/tmp/jv-initial-profile-vmkkcfuu` 및previous-test-instances보존. 원래ungatedVMunits/config/helper/binary/owner/data복원.
- actualfirstboot/ownerHTTPS/consolePTY regression PASS (`.state/firstboot-registration-regression.log`). VM에는새firstboot.sh만추가로영구설치; node_ready.py는opt에있지만운영unit은기존프로필용으로복원되었고새rootmarker도복원삭제. 새gate가live기존legacyprofile에적용된것으로오해하지말것.
- 다음: storage commit뒤versions서비스자동기동/재개, first-run V안내, imagebuilder의versions binaries/configs/roothelper/sudoers/검증다운로드의존성전체통합, 등록profile 실제reboot·journalrecovery순서시험. **현재gate시험은start/restart이며reboot아님**. 새image부팅/실제Pi/mobile/기타남은S0–S4요구유지.

## 체크포인트 — volume 완료→version 준비 자동연결

- 이전turn은등록startupgate progress. 이번에는production storage callback이committed apply/recovery뒤실제UUID/rootjournal을검증하고systemd daemon-reload→versions start/is-active를수행하도록연결. 실패해도volumecommitted상태유지, `prepare_profile` ownerAPI/B키로준비만재시도. Core는version/network확인전기동안함.
- 실제productionmount/systemd에서committedrecovery callback+prepare재시도→versionsactive/Coreinactive PASS, 이어firstprofile/Core31.1/regtest블록1/electrsheight1 및wrongUUIDstartup차단/복원 PASS (`.state/linux-profile-preparation.log`). 이전fixturedata와restoremanifest는 `/var/tmp/jv-initial-profile-mo875z48` 보존. 원래node/profile복원.
- actualTLS/APIauth regression PASS (`.state/profile-preparation-auth.log`), hostbuild/guardunit PASS. TUI S B 안내/실패문구와 V FIRST PROFILE 안내구현; **새B키의실제PTY시험은아직미실행**. testfixture storage server는callback없고productioncallback은위systemd통합으로검증.
- VM opt storage_service.py만새버전설치·restart, 원래Core/electrs/web/Toractive. 운영Rust/web는이전버전. 새sourceUI는hostbuild에있고VMrelease는이전startupguardbackend build.
- 다음: imagebuilder의verifiedversions binaries/configs/roothelpers/sudoers/downloaddeps전체연결 및imagecontents검증, B→V 실제PTY/등록profile reboot/중단복구기동순서. 기존physicalPi/mobile/headlessGUI/전체policy/backup/update등S0–S4남은범위유지. 새image미완성/전체완료아님.

## 진행중 — dev3 image 조립

- imagebuilder에versions tree/Corecompatibility symlink, rootownership, profile/install-core roothelpers와noargs sudoers, versionsconfig, fetch/GPG/CA/filesystemdeps, versions enable을연결. verifier의파일/권한/guard/등록identity없음검증확장.
- 실제ARMVM build `0.1.0-dev3` 시작. `.state/image-dev3-build.log`, host exec session70231. 현재패키지설치/서비스enable단계완료후압축진행여부확인필요. 재시작전에livehandle/output/file/process확인할것. 완성/검증PASS로간주하지말것.

## 체크포인트 — dev3 image 실제build/readonly검증 완료

- 위진행중build session70231 정상완료, verify session35361 정상완료, hostcopy session24238 정상완료. 재시작할필요없음.
- 신규artifact host/VM `dist/justverify-0.1.0-dev3-rpi5-arm64.img.xz` 약856MiB. SHA256 `3571842365fdc706f5d2feaabb6ce94133baa8a1bb6deff7925efb86240b203c`, host와VM일치. host sidecar `.img.xz.sha256` 및 `dist/os-packages-dev3.tsv` 보관. dev/dev2이미지보존.
- `.state/image-dev3-build.log`, `.state/image-dev3-verify.log`: 실제ARM image조립 PASS, readonlye2fsck/identity없음/verifiedCore31.1·electrs0.11.1 hash+실행/Tor0.4.9.11/GPG2.4.7/aiohttp3.13.3/rootownership/sudoers3개/versionsconfigfalse/등록startupgate/servicesenable/systemdverify PASS. 이미지에node-ready/active등록기록없음.
- 새이미지는versions/storage/owner/roothelper/downloaddeps/nodegate까지포함. **실제Pi부팅·전체이미지first-run통합은NOT RUN/BLOCKED**; VM단품/통합증거가이미지부팅증거를대체하지않음. apt snapshot/wheelhash pin/reproducibility, 서명된배포는미완료. 전체RC아님.
- 다음: registeredprofile 실제VM reboot/복구순서, B→V actualPTY, 이미지로실행가능한추가통합검증과headlessGUI/전체policy/모바일/backup/update 등남은범위. 물리장비없음을근거로독립softwarework중단하지말것.

## 체크포인트 — 실제PTY B→V 최초profile 검토

- 이전turn은dev3이미지실제조립/readonly검증progress. 이번에는 `tests/pty_initial_profile.py`를initialprofile통합에연결하여실제non-rootTUI S→B→V→FIRST PROFILE→regtest/review/Esc를검증했다.
- `.state/linux-initial-profile-pty-final.log` PASS: stoppedversionservice를B로기동, V첫profile검토취소후active없음/Coreinactive, 뒤이은실제Core/electrsheight1 및UUIDstartupfault/복원까지통과. 최초실패는EscV가Alt-V로해석된시험입력문제였으며main화면확인후V입력으로수정; parser기준완화없음.
- collector없을때fallback화면에S/V를추가해초기설치경로를안내. ARMreleasebuild PASS. 원래VMnode/helper/binary/owner/units복원, versionservice stopped. backup `/var/tmp/jv-initial-profile-zyho_rpz` 및실패시도 `/var/tmp/jv-initial-profile-wiqdjrqz` 보존.
- dev3이미지는B/V구현포함하며이번fallback문구수정만아직미포함. 기존이미지를덮어쓰지말고후속imageversion으로전달. B actualPTY NOT RUN 항목은이번증거로해결.
- 다음우선: 등록profile실제VM재부팅/중단복구기동순서와완전한imagefirst-run검증. 그외headless일반GUI/전체policy·일반설정/모바일RPC/backup/update/서명·재현빌드/physicalPi·mobile·soak gate유지. 전체RC완료아님.

## 진행중 — 등록profile 실제재부팅

- `tests/linux_initial_profile.py` JV_KEEP_REGISTERED_FOR_REBOOT=1 준비완료. VM이현재전용JUSTVERIFY_UI_TEST볼륨의등록profile로기동되어있으며원래legacyprofile은아직복원전이다.
- 영구backup/checkpoint: `/var/tmp/jv-initial-profile-ksye2gzh/{manifest.json,reboot.json}`. 준비증거 `.state/registered-reboot-prepare.log`.
- 다음명령: VMreboot후 `sudo python3 /home/builder/justverify/tests/linux_registered_reboot.py /var/tmp/jv-initial-profile-ksye2gzh`로검증및baseline복원. 이스크립트finally가원래fstab/config/units/binary/owner/dataUUID/enablement를복원한다. 재부팅없이반복prepare하지말것.

## 체크포인트 — 등록profile 실제VM reboot PASS/복원완료

- 위진행중재부팅 완료. `.state/registered-reboot-prepare.log` 준비후실제systemctlreboot; `.state/registered-reboot-verify.log`에서새bootID/등록UUID/인증서·machine-id·Torhostname불변/기동gate/전체서비스/Coreheight1/electrsheight1 PASS.
- `tests/linux_registered_reboot.py`가baselinefstab/UUID/config/roothelper/Rustbinary/owner/unit파일·enablement를복원했다. 영구checkpoint `/var/tmp/jv-initial-profile-ksye2gzh/reboot.json`은 phase=verified, restored=true. **복원명령재실행불필요**. `.state/registered-reboot-baseline.log` 원래UUID/height2/서비스active추가확인.
- 초기test의optionalkeep mode는test-only envflag이며제품설정옵션아님. 재부팅대응backup/manifest/identityhash/bootID저장, 별도검증복원process추가. 일반실패cleanup도fstab복원후mount하도록보강.
- 현재VM은다시기존legacy개발노드, versionservice stopped/기존enablement복원. 실제QEMU프로세스는reboot동안유지되었고기존live exec session2746의VM이다. 초기등록된별도testvolume/data는보존/unmounted.
- 해결한gate는**generic ARM VM의등록profile재부팅**. dev3image의부팅/실제Pi부팅은여전히NOT RUN/BLOCKED. 다음은중단된version/profile transition의재부팅복구순서, 이미지first-run추가통합, headless일반GUI/전체policy·일반설정/모바일RPC/backup/update/서명·재현빌드/실기soak 등남은범위. 전체RC미완료.

## 체크포인트 — V/R 중단version복구 실제TUI

- 이전turn은등록profile실제VM reboot PASS. 이번에는versionstate의active검증실패가복구UI까지숨기던문제를보완: active_error와transition summary 분리반환, V에R 복구review/cancel/execute연결.
- Hostbuild/ARMrelease PASS. 실제API/PT Y시험에서journalstarting/target22/prior31을주입하고targetbinary를임시rename→state조회/INTERRUPTED표시/R검토/Esc불변/Enter복구→prior31별도data서비스재기동 PASS (`.state/version-recovery-tui.log`). target실행파일없는동안복구성공,이후파일복원.
- 이시험은**journal주입**이며실제kill/reboot로표기하지말것. 기존actualSIGKILL engine증거와구분. VMbaseline복원및Core/electrs/web/Toractive확인. backup `/var/tmp/jv-initial-profile-hitpee2p` 보존. 새sourceR UI는기존dev3이미지미포함.
- 다음우선: 실제versionapply의durablestarting단계에서프로세스중단→VMreboot→startupgate차단→R로priorprofile복구하는시험. 신규test roothelper일시대기장치등을사용하면테스트전용임을명확히하고원래helper/파일복원checkpoint필수. 제품에testbypass를넣지말것.
- 이미지first-run/실제Pi/mobile/전체policy·일반설정/headlessGUI/backup/update/서명·재현빌드/soak 등의남은전체목표유지,RC미완료.

## 진행중 — 실제versionapply SIGKILL→reboot 복구

- 실제firstprofile31준비후22전환apply를실행, roothelper의test-only대기위치에진입한것과durablestarting/active22확인뒤versionservice cgroup을SIGKILL. **journal주입이아님**. 일시wrapper/대기파일삭제및실제helper복원완료.
- VM현재원래baseline미복원. 영구backup `/var/tmp/jv-initial-profile-8osrazyh/{manifest.json,reboot.json}`, 준비증거 `.state/interrupted-boot-prepare.log`.
- 다음actualreboot후 `sudo /opt/justverify-tests/bin/python /home/builder/justverify/tests/linux_registered_reboot.py /var/tmp/jv-initial-profile-8osrazyh` 실행: mismatch startupgate→actualTUI R→prior31검증→baseline복원. 준비test를재실행하지말것.

## 체크포인트 — 실제versionapply SIGKILL→reboot→R 복구 PASS

- 위진행중시험완료. actualAPIapply가starting/active22를영구저장한후서비스cgroupSIGKILL, 원래roothelper복원후실제VM reboot. **journal주입이아님**. `.state/interrupted-boot-prepare.log`.
- reboot후CorePID0/등록gate불일치차단, 실제TUI V/R복구→prior31별도data/Core+electrsheight1/UUID·TLS·machine-id·Torhostname보존/서비스기동 PASS (`.state/interrupted-boot-recovery.log`).
- `/var/tmp/jv-initial-profile-8osrazyh/reboot.json` interrupted=true/phase=verified/restored=true. **이미baseline복원완료, 복원명령다시실행하지말것**. 원래Core/electrs/web/Toractive확인; 임시 `/usr/libexec/justverify-profile-interruption-test` 및pause파일없음. versionservice는원래stopped/enablement복원.
- 신규 `tests/interrupted_version_boot.py`는test-only대기wrapper와actualSIGKILL/postbootPTY복구를구현. product에는testbypass없음. 초기프로필/재부팅시험옵션을통해재현하되기존testdata/backup보존.
- 해결한항목은genericARMVM의actualprocesskill+reboot recovery. 실제전원차단/physicalPi/dev3image전체설치/모바일/soak까지확대해주장하지말것.
- 다음큰범위: imagefirst-run추가통합·소유자준비GUI/전체policy·일반설정·모바일RPC/watch-only·backup/update·서명/재현빌드·실기gate. source최신R UI는dev3이미지미포함이므로후속이미지필요. 전체S0–S4 RC미완료.

## 체크포인트 — 개별client node-read RPC/TLS 경계

- 이전turn은actualSIGKILL/reboot/TUI복구progress. 이번에는남은mobile/RPC범위의기반으로 `web/rpc_gateway.py`, owner `/rpc-clients` 관리 및TLS `/rpc` node-read프로필을구현했다. 독립randomID/secret, hash-only저장, perrequest/inflight반환전폐기확인, allowlist/요청·동시성·크기·시간제한.
- 실제VMCore31.1regtest/TLS에서발급/getblockchaininfo/unauth·admin(wallet포함)·batch거부/분당제한/폐기/원문secret저장·로그부재 PASS (`.state/rpc-client-tls.log`). 기존actualTLS/WS/TUIsecurityregression PASS (`.state/rpc-gateway-web-regression.log`).
- productionweb는아직이전코드; 시험은격리TLS프로세스였다. 추가module로인해 `tests/linux_storage_api.py`의임시server복사에rpc_gateway.py도포함. image는아직이기능미포함.
- **node-read는모바일지갑완성이아님**. 다음: TUI에서client발급/폐기·안전한일회성연결표시/QR, 실제app connection규격공식자료확인, perclientwatch-only/RPC연동, TorRPC전송경로. read-only프로필을fullwallet지원으로표시하지말것.
- 나머지imagefirst-run/headlessGUI/전체policy·일반설정/backup/update/서명·재현빌드/physicalPi·mobile·soak gates유지. S0–S4전체RC미완료.

## 체크포인트 — C client발급/폐기 실제TUI

- 이전turn은node-readRPC/TLS기반 progress. 이번에는 `src/client_ui.rs` C관리화면, `web/manage_clients.py` fixednonroothelper, 공유Clients의파일잠금을구현했다. A이름입력/일회성secretpopup/Esc숨김/R폐기확인·취소; E기존Electrum/Tor정보유지.
- 실제nonrootPTY발급→TLSCore조회→popup숨김→폐기취소조회유지→폐기후401/secret저장·로그없음 PASS (`.state/client-tui-tls-final.log`). 8개독립프로세스동시발급기록유지/0600 PASS (`.state/rpc-client-concurrent.log`). host/ARMbuild PASS.
- 최초시험실패는privatebuilderhome바이너리실행권한이었고별도시험경로copy로해결. E키가이름입력을가로채는충돌도menu-only로수정. builderhome권한완화없음.
- VM원래webstate/identity/service복원. opt/web manage_clients.py·rpc_gateway.py는설치되어있으나운영server/Rustbinary는이전것. 새clientUI는source/VMrelease에있고dev3이미지미포함.
- 다음: 안전한연결QR/payload와모바일앱공식규격확인, watch-only/전송경로/실제client검증. node-read를완전한지갑연동으로표시하지말것. 나머지imagefirst-run/headlessGUI/전체policy·일반설정/backup/update/서명·재현빌드/실기Pi/mobile/soak gate유지. 전체RC미완료.

## 체크포인트 — 공식mobile소스확인/Q Electrum실제QR

- 이전turn은C client발급/폐기progress. 이번에는공식NunchukAndroid/FullyNoded소스commit·filehash/release metadata를catalog/mobile-source-audit.json에기록. FullyNodedparser의host/port/credential추출이gateway /rpc·TLS와자동호환을보장하지않아FN지원QR로표시하지않음.
- `web/electrum_qr.py`, `src/connection_ui.rs` Q/C→Q 일반host:port QR구현. 실제publishedTorElectrum주소만사용. protocol/TLS/proxy/일반텍스트자동import미확인표시. qrcode8.2 pin. browser C/Q buttons추가.
- actualPTY120×40흑백module동일/80×24잘림거부/Esc PASS (`.state/electrum-qr-pty.log`); terminalmodule로재구성후zxingexactdecode PASS (`.state/electrum-qr-decode.log`). 실제phone/camera/app은NOT RUN. RGB명칭차이만등가색상검사로처리했고decoder기준완화없음.
- host/ARMbuild PASS. VM에qrcode8.2와opt/web/electrum_qr.py설치,시험binary/tmp/jv-qr-tui. 운영binary는이전버전. 마지막C→Q/menu/browser버튼추가는hostbuild만검증했으며mainQ의실제PTY경로와구분. dev3이미지에새client/R/QR기능미포함.
- 다음: actualapp정확한release규격/입력·Tor연결/watch-only RPC필요메서드, headlessGUI/전체policy/backup/update/imagefirst-run/서명·재현빌드·실기gate 계속. genericQR를앱자동pairing완료로주장하지말것.

## 체크포인트 — RPC root 경로와 실제 TLS 재시작

- POST `/`를 동일한 node-read gateway에 연결; GET `/`는 브라우저 유지. 실제 JSON-RPC1.0/인증 없음401/wallet·admin403/GET200/서버 프로세스 재시작 후 기존 client 인증/실제 TUI 폐기401 PASS (`.state/rpc-root-restart.log`). 시험용 static 파일 누락을 복구하여 GET assertion 그대로 통과.
- FullyNoded pinned Commands.swift/MakeRPCCall.swift hash·경로 조사 추가. 기본 HTTP/cert 저장 시 HTTPS/지갑별 URL 요구를 확인. `docs/MOBILE_CONNECTIONS.md`를 현재 구현/미구현과 맞게 갱신. watch-only 및 실제 앱은 아직 완료하지 않음.
- dev4 이미지 빌드 진행: `.state/image-dev4-build.log`, VM output `dist/justverify-0.1.0-dev4-rpi5-arm64.img.xz`. 최신 R/C/Q UI와 gateway 포함. 빌드 완료 뒤 `sudo bash image/verify-pi.sh ...` 및 host복사/체크섬 필요. 기존 dev2/dev3 보존.
- image verifier는 packaged web modules/TUI byte equality, root ownership, qrcode8.2 및 gateway/client/QR 실제 import를 추가 검사한다. 물리 Pi 부팅/모바일/전체설정/watch-only/backup/update/재현빌드·서명/soak 등 기존 필수 미충족 범위 유지.

## dev4 offline image verified / generic image boot in progress

- dev4 build and readonly verification PASS, host copied artifact SHA256 `eb44ed28fc3749ebc2df782c95d9129fc7f8a6a2cfb9508a11db3e6fa1804e03`. `dist/justverify-0.1.0-dev4-rpi5-arm64.img.xz`, adjacent checksum and `os-packages-dev4.tsv`. Logs copied to `docs/evidence/pi-image-dev4-verify.log`, RPC evidence to `docs/evidence/rpc-root-restart.log`.
- Disposable image boot test added in `tests/image_boot_probe.py` and `tests/prepare_image_boot_probe.sh`. External Debian kernel/initrd and matching module directory are test fixtures, never additions to release image. Probe checks firstboot/services/gate/TLS claim/authenticated TUI then powers off.
- First boot attempt `.state/image-dev4-virt-boot.log` entered emergency mode because matching external kernel modules were absent (FAT boot mount and loop swap setup). Exact test QEMU process stopped. Prepared VM copy `/var/tmp/jv-virt-probe-dev4.img` now includes matching `/usr/lib/modules/6.12.107+deb13-cloud-arm64`; being copied to host `.state/vm/probe-dev4b.img` for retry. Original compressed image untouched. Previous host test image is preserved.
- Pending: boot retry and inspect `JV_IMAGE_PROBE` result, record honest result and source commit. This is generic ARM image userspace boot, NOT Pi kernel/firmware or physical media acceptance.

## dev4 generic boot passed; dev5 fixes inherited console dialog

- Generic boot retry passed actual firstboot/identity/gate/TLS proof/owner claim/packaged web TUI and powered off (`docs/evidence/image-dev4-virt-probe.json`). Probe QEMU sessions have exited. No physical Pi claim.
- Actual boot also launched OS userconfig. Its packaged script runs chvt tty8, so image build now disables+masks userconfig; offline verifier and boot probe check mask/PID0. dev5 build `.state/image-dev5-build.log` ongoing. dev4 is preserved with known console conflict.
- Probe now performs first boot then actual reboot, preserving only a private test checkpoint in the disposable image, verifies new boot_id and unchanged certificate/machine-id, logs in with the same test owner and displays packaged TUI again before poweroff. Never distribute the booted test copy or its private checkpoint. This revised two-boot probe still needs to run on dev5.
- Next: dev5 build finish → readonly verifier → prepare test clone with matching generic kernel modules → host QEMU two-boot probe → record result/checksum/source and guides. Software/physical remaining S0–S4 requirements unchanged.

## Checkpoint — dev5 image first boot and actual reboot PASS

- dev5 artifact copied to host `dist/justverify-0.1.0-dev5-rpi5-arm64.img.xz`, SHA256 `c97f8bf41e9cf589aa42c67a8f4118bbe8938e7d76461ae0afb7a4e129aa68b2` matches VM build output. Adjacent `.sha256` and `os-packages-dev5.tsv` saved. dev2/dev3/dev4 preserved. Current image includes latest R/C/Q UI and node-read gateway plus userconfig mask.
- Readonly e2fsck, component hashes, latest TUI/web byte equality, root ownership, identity absence, enabled services, userconfig mask, Python gateway/client/QR imports PASS (`docs/evidence/pi-image-dev5-verify.log`).
- Actual disposable image-copy boot on QEMU11.1.1 virt/HVF, 3GiB/2CPU, external Debian6.12.107 kernel/initrd/modules: userconfig masked/PID0, firstboot identity, node-not-registered gate, installed manager/web, verified TLS pairing/claim, actual packaged TUI over WS PASS. Probe initiated actual reboot: new boot_id, unchanged cert/machine-id, same owner login and TUI PASS; then poweroff. `docs/evidence/image-dev5-virt-probe.json`, raw `.state/image-dev5-virt-boot.log`.
- All probe QEMU processes exited. Main development VM remains running with original Core/electrs/Tor/web active; original data/identity preserved. Test-only module/probe/checkpoint modifications are confined to disposable copies. Host booted copies `.state/vm/probe-dev4*.img` and `probe-dev5.img` mode0600, contain generated private identities; NEVER distribute them. VM prepared fresh copies `/var/tmp/jv-virt-probe-dev4.img` and `dev5.img` are reproducible test fixtures, not registered user data.
- External kernel means this is image USERSPACE boot/reboot evidence, not packaged Pi kernel/firmware/media or physical console validation. Pi EEPROM service fails in generic VM as expected; no corresponding physical test passed. Probe did not provision a data disk/Core profile in the image; previously registered-profile integration evidence belongs to development VM.
- Next independent software priorities: watch-only per-client wallet isolation and real FullyNoded RPC requirements; complete policy semantics/general settings; headless owner preparation GUI; registered-profile setup in actual image userspace; encrypted backup/update/reproducibility/signing/notices. Physical Pi/mobile/camera/soak gates remain BLOCKED/NOT RUN. Entire S0–S4 RC remains incomplete; goal stays active.

## In progress — actual watch-only wallet boundary matrix

- Prior goal turn delivered dev5 image userspace firstboot/reboot evidence (progress). Current source adds internal `web/watch_only.py`: stable client-derived wallet paths, private-keys-disabled descriptor provisioning, per-operation invariant, public descriptor import/private batch rejection and constrained read methods. Production default still disablewallet=1; no unsupported mobile route exposed.
- Actual Core22 listdescriptors private argument mismatch found and normalized for public calls. Fixture private rejection input now generated WIF only in memory rather than relying on newer private descriptor export. Initial test teardown kept HTTP connection open while blocking on Core exit; changed client connection lifecycle and graceful stop, PASS emitted only after clean process exit.
- Core22.0 and31.1 actual isolated regtest provisioning/import/balances isolation/forbidden exports/Core restart/unsafe prior wallet rejection/clean shutdown PASS (`.state/watch-only-boundary-final.log`). Test key-source wallet exists only in private temporary regtest directories, never production/watch-only profile.
- Remaining30 verified versions running via session7623, `.state/watch-only-matrix-final.log`; inspect process/session before starting any replacement. Next: collect complete matrix, record evidence, wire owner/profile/client lifecycle and full wallet RPC flow. This boundary alone is not S2/S3 mobile completion; dev5 image predates it.

## Checkpoint — all32 watch-only boundary checks PASS

- Session7623 completed successfully; all32 verified Core releases tested. Evidence `docs/evidence/watch-only-matrix.json` includes each binary hash, implementation/test hashes and actual checks. No running watch-only test process remains; private regtest fixture directories preserved.
- `web/watch_only.py` and test ready for integration, not publicly routed. Next concrete step: explicit owner-controlled watch-only profile activation preserving version/network/data boundaries, couple assigned wallet to client record and revocation, then expose only verified wallet/PSBT routes with actual TLS/TUI integration. Do not simply set disablewallet=0 without journaling, preview, restart checks and data protections.
- dev5 remains latest image and predates new internal module. Remaining full policy/general settings/headless GUI/backup/update/reproducibility/signatures/physicalPi/mobile/soak gates unchanged. Goal remains active and incomplete.

## Checkpoint — watch-only profile activation / actual production TUI PASS

- Previous turn's32 wallet boundary tests were progress. Current work adds Instance.watch_only (default false/omitted in serialized node markers), isolated `<version>-watch-only` directory, preview_mode/version API boolean, TUI V/W and reviewed confirmation. Reuses existing durable transitions/recovery rather than changing current data in place.
- Root bridge validates boolean/derived path/exact marker and generates wallet-enabled Core only for explicit profile; node_ready validates mode/path/config hash. Policy profile parser accepts the new field. Existing node profiles/markers stay compatible, default disablewallet=1.
- Actual Core/electrs version-transition test PASS including same-version separate wallet data, wallet persistence, return to original node data and no wallet RPC; prior failure/crash recovery checks retained (`docs/evidence/watch-profile-transition.log`). ARM release build + host cargo check PASS.
- Actual production systemd/root helper/initial owner-volume gate/PTY W selection→review→cancel, API node↔watch-only switches, wallet resume and prior node restore, wrong UUID denial, existing R recovery PASS (`docs/evidence/watch-profile-tui.log`). Baseline restored; latest test backup `/var/tmp/jv-initial-profile-` path recorded in evidence. Test instances preserved in prior fixture backups. No active test process remains after normal completion.
- Live VM Rust/root helper restored to baseline; new source node_ready installed and backwards compatible. New functionality exists in source/ARM target release, not dev5 image. Latest image remains dev5. Next: authorize/grant/revoke per-client wallets against selected watch-only profile; fixed wallet routes/descriptor import/PSBT and actual TLS/TUI integration. Full settings/backup/update/headless GUI/reproducibility/signatures/physicalPi/mobile/soak requirements remain.

## Checkpoint — client wallet grants / actual TLS and production TUI PASS

- Previous turn's watch-only profile activation was progress. Current code wires owner grant_watch_only and TUI C/W review/cancel/confirm to stable assigned wallets via `web/wallet_gateway.py`. Default client stays node-read. Fixed helper compares reviewed fingerprint; grant binds to selected profile bytes + registered volume UUID and verifies node-ready config hash. Each call checks revocation/registration before and after RPC. Root/direct `/wallet/<assigned-name>` routes expose only verified reads/public imports, filter wallet lists; no client wallet creation/private export/admin/signing.
- Actual isolated Core31.1/TLS owner gating/CSRF/route separation/public import/private batch denial/balance isolation/profile+volume mismatch/revoke/secret non-persistence/missing assigned wallet no-empty-replacement PASS (`docs/evidence/wallet-gateway-tls.log`). Test UUID changes are protocol fixtures, not a physical disk test.
- Actual production profile/TUI C/W cancellation then grant/TLS getwalletinfo private_keys_enabled=false/mode switches preserving exact two-wallet set/R recovery and baseline restoration PASS (`docs/evidence/wallet-grant-production.log`). First run found an obsolete one-wallet fixture expectation after creating the new client wallet; exact two-wallet preservation now asserted, no data deleted. Last addition (grant history/missing-wallet block) separately verified against real Core/TLS after that production run.
- Original data/config/binary/web identity restored. During the first grant test, opt/web/server.py was also copied to the new source; it remains updated along with helper/gateway modules. Later test copies omit that unnecessary server mutation. This is the dedicated VM web service, not a deployment claim. Rust running binary was restored to prior baseline; source/ARM target have C/W. Main Core/electrs/web/Tor services remain active. Test backups/data preserved.
- dev5 remains latest image, predates watch-only profile/client work. Image verifier now checks packaged watch_only/wallet_gateway modules and imports. Next: PSBT create/fund/process-without-signing/finalize/broadcast scoped workflow, app-required method/routing validation, Tor/LAN mobile transport, updated image and tests. General settings/policy, headless GUI, backup/update/signing/reproducibility and physical Pi/mobile/soak gates remain incomplete. Goal active.

## In progress — PSBT TLS matrix and explicit transaction grant

- Previous turn's wallet grant/TLS isolation was progress. Current code adds separate owner grant_transactions and C/T reviewed permission, per-profile transaction grants, list permission label, and PSBT methods guarded by assigned watch-only verification. walletprocesspsbt forces sign=false/rejects true; common funding options only, conflicting fee unit fields rejected. Explicit browser Origin mismatch denied.
- Actual TLS/regtest PSBT funding→no-sign processing→separate test-key wallet signing via internal fixture RPC→finalize→mempool acceptance→broadcast→confirmation→revocation passed all32 official verified Core releases (`.state/psbt-tls-matrix.log`). No actual hardware signer or mobile app was used.
- Added funding-option/key bypass guard and permission label afterwards; final endpoint regression22.0/31.1 passed. Production actual C/T review/cancel/grant/display + TLS PSBT creation now running session40216 (`.state/psbt-final-regression.log`), backup `/var/tmp/jv-initial-profile-v41lx7dw`. Wait for baseline restoration before any further live-profile test.
- Image still dev5 and predates recent wallet/PSBT work. VM root ~7.9GiB free, keep this in mind for future image builds; disposable prepared generic image copies can be regenerated, but preserve user/test data and original artifacts. Full app RPC/coin control compatibility, physical signer/phone, general settings/policy, headless GUI, backup/update/reproducibility/signing/soak remain incomplete.

## Checkpoint — PSBT matrix / production transaction grant PASS

- Session40216 finished successfully. Final Core22/31 regression and actual production PTY C/T permission review/cancel/grant/display/TLS PSBT create passed; original baseline restored. `docs/evidence/psbt-final-regression.log`; matrix `docs/evidence/psbt-tls-matrix.json`. No pending PSBT test process remains.
- Source and ARM target release include separate transaction permission; live VM Rust binary restored to prior baseline as expected. opt/web helper/module copies updated during fixtures, live server may precede newest route changes; do not treat it as an installed release.
- Next: update image with watch-only mode, client grants and PSBT, rerun relevant image/userspace boot checks; audit exact FullyNoded app-required calls/connection transport and remaining wallet coin-control behavior. Other full-scope software and physical gates unchanged. Entire S0–S4 RC incomplete, goal active.

## In progress — dev6 wallet/PSBT image refresh

- Previous goal turn added explicit transaction grants and real PSBT matrix evidence (progress). Current turn builds dev6 from application source commit25af36d; preserve dev2–dev5. `.state/image-dev6-build.log`, live exec session87206. Main Core/electrs/web active before build.
- Builder free space was7.9GiB. Removed only unmounted reproducible `/var/tmp/jv-virt-probe-dev4.img` and `dev5.img` prepared test copies after checking no loop devices attached; host booted private copies and all compressed artifacts/test data remain. Free space13GiB before build.
- `tests/image_boot_probe.py` now also issues a client through the actual packaged owner API, verifies authenticated node RPC reaches unavailable-Core502 rather than401, checks C/T menu through actual WebSocket TUI, and repeats credential/menu checks after actual reboot. Private client secret lives only in disposable test checkpoint, never release artifact/log.
- Next: build completion → readonly verify/source equality/imports → prepared generic ARM clone with matching external kernel modules → two-boot probe → host checksum/manifest/docs. These remain generic image userspace tests, not Pi hardware or registered Core profile tests. Full physical and software acceptance scope remains unchanged.

## dev6 build complete; verifier scratch correction

- Host and builder compressed-image hash match `49f78e4faedf42db56acf7ef3dcb155d22d96173ff55a1965e18e12cddee5d6f`, ~872MiB. Artifact, adjacent checksum and os-packages-dev6.tsv copied to host.
- First verifier attempt failed during extraction because builder `/tmp` is a2.9GiB tmpfs with existing regtest fixtures. Root disk still had13GiB. Verifier now creates its full-image scratch directory under `/var/tmp`; no fixtures deleted and no check weakened. Artifact bytes unchanged.
- Retry session19026 `.state/image-dev6-verify-retry.log` performs readonly verification then prepares `/var/tmp/jv-virt-probe-dev6.img`. First failure log `.state/image-dev6-verify-prepare.log`. Await retry before copying/booting the test clone.

## dev6 offline PASS; terminal probe decoding correction

- Readonly verifier retry and preparation succeeded (`docs/evidence/pi-image-dev6-verify.log`). First copy failed because prepared root-owned test image is now0600; authorized sudo cat transfer fixed this without relaxing permissions.
- First generic boot passed owner enrollment, client issuance and authenticated TUI, but raw-stream substring menu assertion failed. Ratatui emits differential terminal updates, so a raw string search cannot establish displayed menu content. Replaced only the observer with the same VT decoding approach used by existing PTY tests; actual C/T menu assertion retained.
- Test-only pyte0.8.2/wcwidth0.8.3 are copied into disposable image alongside the external kernel modules. They are not added to the pristine dev6 artifact. First failed probe powered off, log `.state/image-dev6-virt-boot.log`.
- Prepared `/var/tmp/jv-virt-probe-dev6b.img` transferred/booting via live session17291; host private `.state/vm/probe-dev6b.img`, final log `.state/image-dev6-virt-boot-final.log`. Await both probe markers and poweroff before reporting success.

## Checkpoint — dev6 image / updated two-boot probe PASS

- dev6 host artifact `dist/justverify-0.1.0-dev6-rpi5-arm64.img.xz`, SHA256 `49f78e4faedf42db56acf7ef3dcb155d22d96173ff55a1965e18e12cddee5d6f`, ~872MiB. Includes application25af36d (watch-only profiles, wallet grants, explicit PSBT transaction permission). Immutable dev2–dev5 preserved.
- Readonly verification PASS (`docs/evidence/pi-image-dev6-verify.log`): filesystem, component/source hashes, root ownership, identity absence, service gates and wallet/PSBT imports. Corrected tmpfs scratch failure via `/var/tmp`, no artifact change.
- Two actual generic ARM boots PASS (`docs/evidence/image-dev6-virt-probe.json`): enrollment/TLS proof, owner client issuance, real TUI C/T menu, actual reboot with identity and client credentials preserved, same owner login/menu. Uses external Debian kernel/modules and test-only VT decoder in disposable copy, NOT Pi kernel/firmware. No registered node data in this probe; authenticated RPC reaches unavailable-Core502 as expected, not a false Core-connection claim.
- Final probe17291 exited after poweroff. Private `.state/vm/probe-dev6*.img` and VM prepared `/var/tmp/jv-virt-probe-dev6*.img` contain test artifacts/identities; never distribute. Main development services/data unaffected. New source bundle/manifest will reference this checkpoint commit.
- Next high-value image test: on a NEW dedicated virtual data disk, exercise owner→real storage API format/UUID mount→version/watch-only selection→Core/electrs/Tor→wallet grant/PSBT→reboot in image userspace. Do not reformat existing test disks or use physical targets. Other full app/network transport/general settings/policy/headless GUI/backup/update/reproducibility/signing and physicalPi/mobile/soak gates remain incomplete. Goal active.

## dev6 deliverable bundle saved

- `dist/justverify-0.1.0-dev6-source.tar.gz` is git archive of14b21fa; application build commit25af36d (later differences are verifier/test/docs). `dist/justverify-0.1.0-dev6-manifest.json` records source commits, base OS/component provenance, artifact hashes, scope and unsigned/incomplete status.
- `dist/justverify-0.1.0-dev6-SHA256SUMS` covers pristine image, source archive, package list and manifest. Image/source/package checksum check PASS; manifest checksum independently checked. No private test copies included.

## In progress — registered image data path

- Added optional installed-image storage/version/watch-only/PSBT probe (`tests/image_data_probe.py`). Only the newly allocated virtual disk with exact serial `JV_IMAGE_DATA_01` is eligible; existing development disks and physical media remain untouched.
- First generic boot command used `/dev/vda2`; adding the data disk changed enumeration. Corrected the test command to verified partition-table PARTUUID `041bba91-02`. Root-selection failure log: `.state/image-data-boot.log`.
- Corrected boot reached HTTPS owner enrollment and committed the new data volume, but `profile_ready` was false; no full integration PASS. `.state/image-data-boot-rootfix.log`. Preserve private host root `.state/vm/probe-dev6-data.img` and data `.state/vm/image-data-01.qcow2`; NEVER reformat this disk. Journal UUID `4d76109a-9b96-4348-ac9d-eb2a4d99d786`, phase committed.
- Read-only diagnostic inspection of that test clone confirmed the committed record. A subsequent diagnostic boot ran installed `prepare_profile()` successfully without formatting. This suggests a first-setup timing/identity issue, not yet a proven cause. Diagnostic probe replaced only the disposable clone's test entry point; pristine dev6 unchanged.
- Added secret-free traceback frame locations and failed-profile mount/service diagnostics to the test observer. Preparing fresh `.state/vm/probe-dev6-data02.img` and NEW `.state/vm/image-data-02.qcow2` (same explicitly designated test serial). Transfer session22101; do not boot before transfer completes. Reused only the unbooted reproducible builder prepared copy `/var/tmp/jv-virt-probe-dev6-data.img`, with updated test scripts.
- Next: reproduce once with diagnostics, fix underlying failure, retain failure evidence, rerun installed-image integration and actual reboot. No full RC claim; prior software and physical acceptance gaps remain.

## First-setup failure reproduced and source fix in test

- Fresh disk02 reproduced the same failure: committed volume, source `/proc/self/fd/6`, empty `findmnt UUID`; safe evidence `docs/evidence/image-dev6-data-initial-failure.json`. Root/data02 private copies are preserved and powered off; never reformat them.
- `scripts/volume_setup.py` now mounts through the device-number path checked against the still-open descriptor; formatting/signature and post-mount device checks retained. `tests/linux_volume_mount_identity.py` creates its own new loop-file ext4 and verifies immediate UUID resolution as root and justverify after closing the descriptor. PASS: `docs/evidence/volume-mount-identity.log`.
- Test helper saves owner/client credentials privately before data mutations for failure diagnosis; no secrets in output or release. Secret-free traceback frame locations retained. Full initial registration assertions unchanged.
- Prepared builder test clone now contains the source mount fix and latest observer; pristine dev6 does NOT. Transfer session11711 creates host `.state/vm/probe-dev6-data03.img` and new `.state/vm/image-data-03.qcow2`. On completion, boot with PARTUUID041bba91-02 and designated serialJV_IMAGE_DATA_01. This is a patched test copy; after success build/verify a new dev7 artifact before release claims.

## Patched installed-image full data probe PASS; dev7 next

- Session62837 completed first and actual second boot successfully: HTTPS storage commit → nonroot installed version API watch-only31.1/regtest activation → actual Core block/electrs height1 → Tor service/public identity → assigned TLS wallet/private keys disabled and PSBT creation → real authenticated TUI C/T menu → actual reboot, same UUID/height/wallet/Tor identities and credentials. Evidence `docs/evidence/image-dev6-patched-data-probe.json`. Still external Debian kernel/modules, NOT Pi firmware/kernel or physical mobile signer.
- Host private root/data03 preserved. No existing disk reformatted. Source observer now labels second-boot identity checks accurately; prior evidence explains inherited label.
- Removed only the three unmounted, reproducible builder prepared copies dev6/dev6b/dev6-data after verifying loop inventory; host copies and pristine artifacts preserved. Builder free13GiB. Main Core/electrs/web remain active.
- Next build immutable dev7 from this mount fix, then readonly artifact verification and a fresh installed-image two-boot data probe. dev6 has a known initial-profile preparation defect and is not a release candidate. Full S0–S4 remains incomplete; software work continues.

## dev7 build running

- Source checkpoint committed as `711e6ff`. Build session84472, host log `.state/image-dev7-build.log`, builder output `dist/justverify-0.1.0-dev7-rpi5-arm64.img.xz`. Inputs: verified base `/home/builder/artifacts/base.img.xz`, Core31.1 matrix binary, existing unchanged ARM Rust release and electrs0.11.1. Mount fix is packaged Python source.
- Await build exit; then `image/verify-pi.sh` against current source/target, prepare fresh clone with `tests/prepare_image_boot_probe.sh ... --with-data`, copy and boot with external generic kernel and verified PARTUUID. Allocate a NEW explicitly designated virtual data disk; never reuse data01–03 for formatting. Save artifact checksum/package list and new manifest/source bundle after verification.

## dev7 built, copied and verification underway

- Build84472 exited0. Host/builder SHA256 match `2743fba94fe20589b2186935262402923860ee638f20f5b383087e1824eb262b`; artifact `dist/justverify-0.1.0-dev7-rpi5-arm64.img.xz`, adjacent checksum and `dist/os-packages-dev7.tsv` saved.
- Initial readonly verify and test preparation85924 exited0. Strengthened verifier to compare storage/profile Python bytes against current source as well as web/Rust components; rerun67676 writes `docs/evidence/pi-image-dev7-verify.log`. This verifier-only change does not change image content.
- Transfer83836 copies prepared `/var/tmp/jv-virt-probe-dev7-data.img` to private host `.state/vm/probe-dev7-data.img`, then creates NEW data04. Await completion before boot. Dedicated data01–03 preserved. Use external generic kernel/PARTUUID and fixed test serial as before; actual Pi boot remains BLOCKED.

## dev7 artifact and registered image two-boot PASS

- Final readonly verifier92924 exited0, `docs/evidence/pi-image-dev7-verify.log`. Strengthened check initially used the wrong profile helper path; corrected mapping to actual `/usr/libexec/justverify-profile` without removing its byte comparison. Initial observer failure preserved `.state/image-dev7-verifier-path-failure.log`; image unchanged.
- Image boot19923 exited0 after first PASS → actual reboot → second PASS → poweroff. Evidence `docs/evidence/image-dev7-data-probe.json`: fresh data04 committed through HTTPS; nonroot installed version API selected31.1/regtest/watch-only; Core mined1, electrs indexed1; all six services active; TLS assigned wallet disallows private keys and creates PSBT; real authenticated TUI C/T menu; same UUID, height, wallet, Tor public identities, owner/client credentials after reboot. External Debian kernel/modules and test observer only; packaged application unchanged.
- SHA256 `2743fba94fe20589b2186935262402923860ee638f20f5b383087e1824eb262b`. Artifact+checksum+os-packages-dev7.tsv saved in host dist. Private booted `.state/vm/probe-dev7-data.img` and data04 must never be distributed. Source/manifest bundle follows this evidence checkpoint.
- Current turn made concrete progress (first-setup defect fixed, actual image data flow verified), so goal remains active. Next software work: exact mobile client transport/coin-control coverage and remaining general settings/policy/headless UI/backup/update/release reproducibility gates. Pi/mobile/camera/hardware signer/long soak still need actual targets; not overall RC complete.

## dev7 deliverables saved

- `dist/justverify-0.1.0-dev7-source.tar.gz`: source/evidence commit02065d9. `dist/justverify-0.1.0-dev7-manifest.json`: packaged application checkpoint711e6ff, base/component provenance, file hashes and explicit limits. `dist/justverify-0.1.0-dev7-SHA256SUMS`: image, source, package list and manifest. Hashes generated and image independently matched builder.
- Main development Core/electrs/web still active; root free8.7GiB. All probe QEMU sessions ended. Prepared unbooted builder copy `/var/tmp/jv-virt-probe-dev7-data.img` remains reproducible; private host test copies/data01–04 preserved. No physical media modified, no public release or signing performed.

## Coin-control implementation and 32-Core TLS matrix PASS

- Previous goal turn was progress: fixed initial mount UUID and verified dev7 image. This turn re-read requirements/current tree and verified development Core/electrs/web active before isolated work.
- Audited pinned FullyNoded UTXO/Locked view controllers, added source URLs/hashes to mobile catalog. Implemented assigned-wallet `listlockunspent` read and transaction-authorized `lockunspent`, strict shared-version argument schema and whole-list outpoint validation. TUI C/T review now mentions coin locking. Node-read/watch-only alone cannot mutate locks; permanent locking is not exposed.
- `tests/wallet_gateway_tls.py` now tests actual coin locking, all-coins funding exclusion, unlock/funding recovery, same-address other-wallet isolation, wrong-wallet paths, malformed requests and preserved lock state. All32 official ARM Core releases22.0–31.1 PASS with existing PSBT/broadcast/revocation suite. Evidence `docs/evidence/coin-control-tls-matrix.json`, logs `.state/coin-control-matrix/`. Matrix91410 exited0. Fixtures use new regtest directories, no existing node data touched.
- Initial attempt used test-decoder Python venv lacking aiohttp; switched to installed runtime `/opt/justverify/venv/bin/python`. No test dependency substituted. Final Rust release build20108 writes `.state/coin-control-build.log`; confirm exit before reporting build completion. Final Python source already tested; no production service replaced.
- dev7 artifacts remain unchanged and do not include coin-control. Next image refresh must include this source after related mobile transport work. Remaining actual app transport/certificate/QR, LAN Electrum TLS/Tor RPC, full general settings/policy, headless UI, backup/update/reproducibility/signing and physical gates are still required. Goal active, not RC complete.

- Final ARM release build20108 exited0. Matrix evidence contains32 PASS rows with all three required check groups. Main development Core/electrs/web remain active. Source and restart point saved; no outstanding probe process.

## In progress — LAN Electrum TLS and connection UI

- Prior goal turn was progress (coin-control32-Core matrix). Current tree was clean at start; main development services active. Added fixed loopback Electrum→LAN TLS relay, nonroot systemd unit using per-device web certificate, registration gate, private IPv4 source allowlist in Python and systemd, bounded buffers/connections/timeouts, and no request logging. Unit is wanted by/part of electrs; image builder/verifier updated.
- First direct integration attempt was correctly refused because baseline VM has no node-ready marker. Did not weaken the gate. Moved TLS tests into actual production initial-profile fixture. First fixture invocation used wrong Python venv lacking pyte; cleanup restored baseline. Correct decoder venv invocation passed registered TLS, trusted/untrusted cert, plaintext refusal, backend/TLS restart and actual documentation-range non-LAN source refusal; temporary loopback address removed.
- Added Q→L LAN/TLS and Q→T Tor selection, certificate SHA256 and explicit SSL selection instruction. Actual nonroot PTY matrix/color/resize test PASS; captured LAN QR digitally decoded to exact payload (`docs/evidence/electrum-lan-qr-decode.json`). Capture is private `.state/electrum-lan-qr-capture.json`. Phone/app not tested.
- Later rapid profile switches exposed TLS start-limit-hit, despite earlier TLS checks passing. Fixed by adding this service to the existing explicit profile transition stop/reset-failed set, retaining bounded automatic restart policy. Added assertion after each mode switch. Final integration12176 writes `.state/electrum-tls-final-profile.log`; await exit and baseline restoration before final PASS.
- New files/source are not in dev7. Image data probe now additionally demands actual TLS headers before/after reboot; next image build must include TLS and coin-control. Main installed TLS unit and scripts are development copies; baseline profile has no registration marker and should keep TLS inactive. No physical media changed.

- Added per-switch TLS active assertion exposed another ordering issue: electrs' Wants job can still be starting when profile apply returns. Profile helper now explicitly waits for the TLS start job alongside other services. Existing TUI client fixture temporarily swaps the shared identity directory; it now stops/restores the TLS consumer too, avoiding test-only permission errors during that swap. Final retry54085 `.state/electrum-tls-final2-profile.log`; prior failed assertion log preserved `.state/electrum-tls-final-profile.log`, baseline restoration confirmed there.

## LAN TLS registered profile integration PASS

- Retry54085 exited0. `docs/evidence/electrum-tls-profile.log` records actual registered Core31.1/electrs0.11.1 TLS/header, nonroot UID, certificate rejection, plaintext rejection, non-LAN source rejection, backend/TLS restart, real Q/L PTY QR, wallet grants and all repeated profile switch assertions. Baseline data/profile/binary restored. Main Core/electrs/web active; TLS inactive with Result=success because baseline node-ready marker is absent. Temporary non-LAN address removed.
- Captured real terminal QR decoded exactly (`docs/evidence/electrum-lan-qr-decode.json`). ARM release built and PTY tested; only subsequent Rust whitespace formatting differs. No new crate or Python dependency required. New unit/module and public QR helper remain installed in development VM; runtime app baseline was restored by fixture.
- Next: build new immutable dev8 containing coin-control and TLS (current Rust source must be built/synced), readonly verification, new disposable image/data disk two-boot probe now requiring TLS headers, then source/manifest/checksums. Do not run updated verifier against dev7 expecting source equality. Existing image/data01–04 copies must not be reformatted. Other remaining S0–S4 software and physical gates unchanged; current goal turn made implementation/integration progress, not an overall completion claim.

## dev8 build in progress

- Previous turn made concrete LAN TLS implementation/integration progress. This turn verified clean source and active baseline services; builder free7.9GiB. Build38431 `.state/image-dev8-build.log` from application commitfd3d4b1; ARM release build passed, immutable dev8 assembly running.
- Extended disposable image observer to exercise packaged coin-control routes and Q/L LAN TLS connection/certificate screen in addition to actual TLS headers and registered wallet/PSBT, then repeat after reboot. These are test-only changes, no change to packaged application. Sync tests after build before preparing the clone.
- Next allocate NEW virtual data05; preserve all existing image/data01–04. Verify artifact readonly and current source bytes, copy/hash host artifact, prepare external-kernel image test clone, run two boots, save provenance/source bundle. This remains generic image userspace, not physical Pi or mobile app acceptance.

- Removed only unmounted reproducible builder `/var/tmp/jv-virt-probe-dev7-data.img` after checking loop attachments. Host private dev7 test copy/data04 and pristine dev7 artifacts remain preserved. Build process44386/44473 and compressor45553 were confirmed live during compression; not treated as stopped from a quiet log.

## dev8 built and readonly verification PASS

- Build38431 and verify/prepare34448 exited0. Host and builder SHA256 match `13296d8e019a4f779a60d5aa2bcdb5c8bbb90b0c779ebf4c8843544edd47f8aa`. Image, adjacent checksum, os-packages-dev8.tsv saved in dist. Evidence `docs/evidence/pi-image-dev8-verify.log` covers source bytes including TLS module/helper/unit, enabled service dependency, filesystem/identity absence and runtimes.
- Prepared clone `/var/tmp/jv-virt-probe-dev8-data.img` uses updated test observer; disk table id verified0x041bba91. Transfer62407 to private host `.state/vm/probe-dev8-data.img`, then creation of NEW `.state/vm/image-data-05.qcow2`. Await completion, verify copy, then boot with PARTUUID041bba91-02/external kernel and explicit JV_IMAGE_DATA_01 test serial. Prior test disks unchanged. Full actual Pi/mobile acceptance remains incomplete.

## dev8 registered image two-boot PASS

- Transfer62407 finished; prepared-copy SHA256 and8GiB size matched before boot. Probe90084 exited0 after first PASS → actual reboot → second PASS → poweroff. Evidence `docs/evidence/image-dev8-data-probe.json`: fresh volume through installed HTTPS API, watch-only31.1/regtest, Core block1/electrs height1, trusted TLS50002 headers on both boots, assigned wallet/PSBT/coin-control routes, authenticated TUI C/T and Q/L certificate screen, same UUID/height/wallet/Tor identities/owner-client credentials after reboot.
- Packaged production source unchanged; only external generic kernel/modules and test observer/decoder added. NOT Pi firmware/kernel or mobile-app verification. Private host root/data05 preserved, not distributable. Previous test disks01–04 unchanged.
- dev8 SHA256 `13296d8e019a4f779a60d5aa2bcdb5c8bbb90b0c779ebf4c8843544edd47f8aa`, includes coin-control and LAN TLS from fd3d4b1. Source archive/manifest follows this evidence checkpoint. Update docs/INSTALL stale dev2 example and dev6-latest label to current explicit build tag.
- Current turn is progress, goal active. Next meaningful software scope: protected Tor RPC/mobile app call sequence and certificate trust; remaining general settings/policy, headless GUI, encrypted backup/update, reproducibility/signing/notice gates remain. Physical Pi/mobile/camera/long-soak tests still require targets, so no overall RC completion.

## dev8 deliverable bundle saved

- `dist/justverify-0.1.0-dev8-source.tar.gz` archives96abd51 (source plus evidence). `dist/justverify-0.1.0-dev8-manifest.json` records applicationfd3d4b1, OS/component provenance, hashes and explicit limits. `dist/justverify-0.1.0-dev8-SHA256SUMS` covers image/source/package list/manifest. Bundle generation2443 exited0; image hash independently matched builder.
- Main Core/electrs/web remain active; builder root free7.1GiB. All image probes ended. Reproducible unbooted builder `/var/tmp/jv-virt-probe-dev8-data.img` remains; private host booted image/data05 preserved and excluded from release. Prior images and data disks unchanged. No physical recording, public release or signing performed.

## Tor RPC transport boundary and actual onion PASS

- Previous turn was progress (dev8 bundle/image verification). This turn inspected clean source and existing gateways, then added optional `server.py --tor-rpc` listener on fixed127.0.0.1:28443. It reuses the same Gateway object and exposes only POST root/rpc/assigned-wallet routes. Default flag false; production unit/Tor config unchanged, so remote access is not silently enabled.
- Extended real Core/TLS test with no-owner/static/TUI routes, wallet path isolation, HTTPS+loopback combined30-call rate limit, shared credentials and revocation. Core22.0/31.1 PASS. Real isolated Tor SOCKS/v3 onion→Core31.1 height/watch-only wallet/anonymous refusal/admin-route refusal/revoked refusal PASS. Evidence `docs/evidence/tor-rpc-transport.log`; integration95974 exited0. Test listener closed after app cleanup; main Core/electrs/web remain active.
- Temporary Tor instance pid46471, `/var/tmp/jv-tor-rpc-aufdwijn`, SOCKS19651; generated onion keys remain private and are not printed or distributed. Exact process command was checked before SIGTERM after successful test. Metadata `/home/builder/justverify/.tor-rpc-test.json` is test-only, not source/image. No production Tor config changed.
- Next: implement owner-reviewed persistent remote-RPC enable/disable and connection display without exposing management endpoints, then actual service/image/reboot tests. Current transport source is not in dev8 and does not complete mobile support. Other settings/policy/headless/backup/update/reproducibility/signing/physical gates remain; goal active and this turn made concrete progress.

## Remote RPC persistent owner API implemented and tested

- Previous turn was progress (actual Tor transport). Current tree was clean. Added `web/remote_rpc.py` and HTTPS `/remote-rpc` state/preview/apply. Owner session+Origin+CSRF required; apply rechecks administrator password with existing attempt limit.120-second one-use review token binds previous file digest; settings contain no password.
- Private atomic `applying`/`committed` journal; committed enable can restore the listener, unfinished state stays closed. Failed start closes current listener and leaves recovery state while HTTPS management remains usable. Shared Gateway authorization/quotas preserved. Development `--tor-rpc` transport test mode remains separate.
- `tests/remote_rpc_control.py` actual HTTPS and baseline Core read-only query PASS: auth/CSRF/reauth, preview no side effect, commit enable/disable, new server object/socket lifecycle restore, directly seeded unfinished file refusal/review recovery, stale review refusal, actual occupied-port failure and owner recovery. This is NOT process SIGKILL or OS reboot evidence. Initial conflict fixture hit TIME_WAIT before occupying the socket; SO_REUSEADDR fixed fixture setup without allowing concurrent listener reuse. Failed log `.state/remote-rpc-final.log`; final evidence `docs/evidence/remote-rpc-control.log`.
- Combined retry12462 exited0, existing Core31.1 wallet/coin-control/PSBT/revocation suite also PASS. Main Core/electrs/web unchanged and active. New module is included in image source verifier and dependent server-copy fixtures. Final validation tightened malformed schema rejection; Python compile check passed.
- Next: connect state/preview/apply to local TUI with secure password input and narrow private IPC; integrate opt-in Tor mapping/address display; run real process/service/image reboot tests. Current API is not a complete user flow, no updated image yet. Remaining full S0–S4 gates unchanged; goal active with concrete implementation/test progress.

## Remote RPC TUI, product Tor onion and Quick Connect PASS

- C/O now uses an owner-only Unix control socket; Linux peer UID,0700 state,0600 socket, existing live-socket preservation, password reauthentication and one-use review are enforced. Actual nonroot PTY cancel/wrong password/masked input/enable/Core query/web process restore/disable PASS. Existing W/T wallet and PSBT flows pass in the same registered-profile run.
- Added a third persistent Tor identity for restricted RPC, external8332→loopback28443. Product systemd Tor SOCKS→generated v3 RPC onion→authenticated Core31.1 PASS; anonymous401 and `/login`404. P2P/Electrum/RPC identities are separate and private keys remain0600. No address or secret logged.
- Fully Noded official source commit `d0d1502eef2840c0457aa321b88cf606ee8b4650` confirms btcrpc Quick Connect URI. Newly issued passwords are192-bit hex. C/A→Q explicitly displays the sensitive QR once; actual PTY black/white modules, quiet zone, narrow-screen refusal and independent digital decode PASS. Evidence `docs/evidence/remote-rpc-tui-tor.log`, `rpc-quick-connect-qr.json`.
- First attempt to rerun standalone network lifecycle after installing the new unit was invalid because the preserved development baseline intentionally lacks `node-ready.json`; restarting guarded electrs therefore skipped it. The registered-profile integration then passed. `vm_install_network_services.sh` now restarts updated active configs instead of relying on `enable --now`. The exact pre-test electrs unit backup was restored and baseline Core/electrs/Tor/web are active with original UUID; no marker was fabricated.
- dev8 does not contain this work. Next: extend image observer for reviewed remote enable, product onion, sensitive QR and actual reboot restore; build a new immutable image tag and verify it. Physical phone/Pi/camera/24h and remaining settings/backup/update/reproducibility/signing gates remain incomplete; goal active.

## Checkpoint — dev9 image remote RPC / Quick Connect two-boot PASS

- Immutable development artifact `dist/justverify-0.1.0-dev9-rpi5-arm64.img.xz` was built from application commit `330386c`, copied without overwriting dev8 or earlier artifacts, and matched the builder SHA256 `604f4d8e813995503a7791c8cc8b1a589bbff0a81829298f0ded1e5054001c5c` (914770804 bytes). Package inventory is `dist/os-packages-dev9.tsv`.
- Read-only verification PASS (`docs/evidence/pi-image-dev9-verify.log`): e2fsck, exact Core/electrs/Tor/source hashes, root-owned helpers, absence of machine-id/SSH keys/web identity/Tor private identities, enabled services, ARM execution, aiohttp3.13.3 and qrcode8.2 imports. Raspberry Pi firmware and hardware boot remain NOT RUN/BLOCKED.
- Clean disposable dev9 copy + new dedicated data11 qcow2 completed two actual QEMU ARM boots (`docs/evidence/image-dev9-data-probe.json`). First boot PASS: owner TLS enrollment, storage registration, Core31.1 watch-only regtest/electrs, wallet/PSBT/coin control, LAN TLS, reviewed remote RPC, real product Tor v3 onion RPC, anonymous401, forbidden `/login`404, browser TUI and black/white sensitive Fully Noded QR. Actual reboot then PASS: same device identity, owner/client credentials, volume/wallet/chain, Core/electrs/LAN TLS, committed listener and actual onion RPC. One reboot and final poweroff observed; data qcow2 check PASS.
- Failed disposable attempts are retained and recorded. They exposed observer timing faults: initial Tor circuit startup, partial terminal frames and back-to-back Escape keys. The real assertions were retained; the observer now retries Tor within a fixed deadline and waits for each complete screen transition. Private booted copies/data06–11/logs remain mode0600 under `.state` and must never be distributed.
- dev9 is still DEVELOPMENT and unsigned. Physical Pi5/EEPROM/HAT/media boot, installed Fully Noded/Nunchuk on a real phone, camera and separate-LAN trust flow, 24-hour soak, encrypted configuration/Tor identity backup and restore, atomic system update/last-known-good, clean-build reproducibility, release signing/notices, full settings parity and headless GUI completeness remain incomplete. Do not report S0–S4 or RC complete.

## Checkpoint — dev9 deliverable bundle saved

- `dist/justverify-0.1.0-dev9-source.tar.gz` is a byte-verified `git archive` of evidence checkpoint `774ceb932e04f24f77a422ec93c018ba6d7ae114`; SHA256 `aec99420575167264868931459543142afeca95e53923f4057f2472428f6b385`.
- `dist/justverify-0.1.0-dev9-manifest.json` records application build commit `330386c`, observer commit `db3c9b5`, base OS and component provenance, evidence, exact artifact sizes/hashes and all material limits; SHA256 `c7fea4dbe07ee1726a22efe0fca45668f87e49c8327809c31682fdf8079b5f30`.
- `dist/justverify-0.1.0-dev9-SHA256SUMS` covers the pristine image, source archive, package inventory and manifest. All entries and the adjacent image checksum passed. No private booted image, credential checkpoint, onion identity or data disk is included. Bundle remains unsigned and is not an RC.
- Next software work: encrypted configuration/Tor identity backup and verified restore, then atomic application/system update with last-known-good failure recovery, clean-build reproducibility and notices/signing preparation. Physical Pi5, actual mobile apps/camera/separate LAN and soak stay explicit external gates.

## 2026-09-12 upstream + public network audit in progress

- User steered current S0–S4 work toward exhaustive official Umbrel/Core/electrs parity and real public-testnet/RPC/transaction verification. Preserved all pre-existing uncommitted backup WIP (6 new modules/tests/unit + image/TUI changes); backup production restore remains NOT RUN and needs safety review before activation. dev9 immutable bundle unchanged.
- Read AGENTS.md, PROJECT_BRIEF_KO.md, current source/status. Baseline Debian VM Core/electrs active, root free5.6GiB. Host free215GiB; therefore new public testnet4 data uses host `.state/public-testnet4-audit` only. Existing mainnet/data disks untouched.
- Direct official Git clones under private `.state/upstream-audit`: umbrel-bitcoin2fe07948, Umbrel bfa79ed2, electrs HEAD da1860e6. Core31.1 peeled tag9be056a8; product electrs0.11.1/35216c6d. Source hashes and pins in docs/evidence/upstream-audit.json. Rebuilt UMBREL_PARITY.md with all metadata keys and current gaps. No upstream implementation copied.
- Fixed READY false-positive: require double-SHA256 Electrum header tip equality in addition to matching height/Core IBD=false. Genesis hash/parser regression added; live regression validation in progress.
- New tests/signed_chain_audit.py PASS on real host Core31.1/electrs0.11.1: actual test wallets, funding/signature, Electrum broadcast, Core+electrs mempool, confirmations0/1/3, header hash+height, process restart and wallet/policy/index persistence. docs/evidence/signed-chain-audit.json includes txid, RPC success list and full unexercised inventory. This is NOT device reboot or all-RPC completion.
- Real public testnet4 Core pid45115, electrs pid45208 started independently with private data/logs/checkpoint, loopback RPC29443/P2P29444/Electrum29401/metrics29424. Check process identity before restarting, never launch duplicates. IBD progressing; electrs correctly waits. No sync PASS yet.
- Faucet coinfaucet.eu successfully reports0.00425423 tBTC to dedicated test address; funding tx ef9a651a6999b844ae42c6c692e7bd4486506db9adada696f69e0200e7edd77e. Independent mempool.space status observed unconfirmed. Private funding address/metadata saved. These are testnet coins only. Own public spend/propagation remains NOT RUN until sync/funding availability.
- Next: complete public sync/header-tip+recent-block proof, spend/sign/broadcast and independently verify; finish RPC coverage, general network/settings omissions, live product tip regression + service/reboot checks, then update acceptance/evidence. Full RC remains incomplete.

### Audit checkpoint: real Tor outbound, complete gateway RPC set, VM reboot

- Added explicit onion=127.0.0.1:9050 and listenonion=0 to generated Core profiles/base image config. Persistent incoming identities remain owned by Tor; Clearnet stays direct. tests/linux_tor_outbound.py passed actual product Tor SOCKS→P2P onion→Core31.1 regtest version handshake and effective getnetworkinfo proxy values. UI selection for outbound/incoming/proxy still unfinished.
- Strengthened registered profile test with actual product collector READY/tip checks. Two failed attempts exposed development-only manager regtest.conf overriding generated20-profile.conf, producing RPC cookie unavailable. Fixture now backs up/removes only that legacy test override during production-profile test and restores it in finally. No success assertion weakened. Final docs/evidence/upstream-profile-audit.log PASS with correct product header tip and proxy values, TLS/QR/watch-only/version recovery paths.
- Extended real HTTPS gateway tests to assert every published node-read/watch-only/transaction method succeeds with valid arguments, without changing quotas or replacing Core. Core31.1 and22.0 PASS. 37 gateway methods have positive outcomes; forbidden/revoked cases tracked separately. docs/RPC_AUDIT.md and docs/evidence/rpc-gateway-audit.json distinguish gateway success/direct regtest/help-only.151 Core31.1 help descriptions captured; other Core RPC semantics remain NOT RUN.
- Prepared registered disposable VM volume via backup /var/tmp/jv-initial-profile-8ju0zk07, performed actual sudo reboot, then tests/linux_registered_reboot.py PASS new boot ID, same UUID/identity, Core/electrs hash+height, product READY, Tor proxy and direct Clearnet. Baseline UUID/fstab/profile/binaries/owner/legacy manager drop-in restored; Core/electrs/web active. Evidence upstream-reboot-audit.log. Physical Pi remains BLOCKED.
- scripts/public_testnet_audit.py is an actual running resume-safe workflow (host exec session81028, .state/public-testnet4-audit/runner.log). It waits for IBD=false, equal Core headers/blocks/electrs tip hash, recent block, independent block hash; then persists signed transaction before broadcast, checks external tx status and electrs wallet history, restarts dedicated processes with maxmempool420 and verifies persistence. Work is still RUNNING, not PASS. Check process/checkpoint before any restart; no duplicate send. Last observed near149k/151993; electrs still waiting for Core IBD.20GiB host free-space reserve enforced.

### Public testnet4 sync/spend completed with recorded transient fork

- Public Core31.1/electrs0.11.1 finished real testnet4 IBD/indexing: IBD=false, Core blocks=headers=electrs height151993, same80-byte header hash. Initially independent mempool.space used an equal-work competing8-block branch; both headers had equal chainwork. Preserved docs/evidence/testnet4-fork-observation.json; no invalidateblock/preciousblock/consensus bypass was used. At height151994 normal next-block selection converged and independent hash matched; `public_testnet_audit.py --observe` recorded latest_sync PASS.
- Latest block timestamps were about108minutes in the future. Verified Core31.1 chain.h MAX_FUTURE_BLOCK_TIME=2h; corrected the observer's mistaken exclusion of valid future timestamps, keeping an explicit two-hour freshness/future bound and recording exact skew/source.
- Funding faucet tx ef9a651a6999b844ae42c6c692e7bd4486506db9adada696f69e0200e7edd77e was independently fetched/testmempoolaccepted then relayed locally after IBD (not initially in local mempool). Test wallet received0.00425423 tBTC. Own signed spend tx50fae20278c3230093255e222d7a30e10d20fc77f68f6e07fcd7d91890ac7578 accepted locally and independently found by mempool.space; Core/electrs history and wallet agree. Last observed confirmations0/unconfirmed, never called confirmed.
- Dedicated Core/electrs processes were gracefully restarted, maxmempool420 applied and RPC verified, same chain/wallet/mempool/history retained, handshaken peers verified after restart. Evidence docs/evidence/public-testnet4-audit.json. Runner has FINISHED; only the dedicated Core/electrs processes remain active. Their new PIDs are in .state/public-testnet4-audit/{process,electrs-process}.json. `--observe` is read-only status refresh; normal run resumes same signed transaction and also repeats restart. No automatic future agent execution is configured.

### Outgoing selection and coordinated restart WIP

- Added bounded onlynet (ipv4,ipv6,onion) and fixed Tor proxy0/1 to the existing policy editor/API. Input injection/arbitrary proxy endpoint/duplicate network refused. UI describes automatic outgoing vs incoming/manual distinction. Stored repeated onlynet lines round-trip; preview includes derived noonion and transport warnings. Actual getnetworkinfo values are checked both in preflight and after service restart.
- Real Core22 preflight caught its documented onlynet+onion/proxy interaction: excluding onion did not disable Tor. Confirmed official v22 init.cpp warning and actual includeconf precedence. Added derived noonion=1 when onion is excluded, with validation tying it to onlynet. Preflight now mirrors production base-config+included-managed-file layout. Core22 and31.1 three-mode real preflight passed; full32-release/96-mode matrix session79660 running, .state/outgoing-preflight-matrix.log.
- Registered three-mode API integration initially failed after multiple Core-only restarts because electrs exited on P2P loss and hit its3/60s restart limit. Fixed image/restart-core.sh to stop TLS/electrs first, explicitly reset bounded counters for the reviewed operation, restart Core, then start electrs/TLS. Existing automatic failure limits retained. Actual registered repeat changes now PASS (outgoing-profile-audit.log); old restart helper preserved/restored by fixture.
- Actual Core31.1 testnet4 Clearnet peer P2P handshake through product Tor PASS, verified process-owned established TCP sockets go to loopback SOCKS9050 with no direct nonloopback TCP connection. Evidence tor-clearnet-audit.log. Temporary test Core stopped; no baseline data changed.
- Next in flight: nonroot PTY edit/review/cancel/apply for onlynet and proxy, keep reviewed proxy1 selection through an actual VM reboot (session38439, .state/outgoing-tui-reboot-prepare.log). Wait READY FOR REBOOT, read its backup path, reboot VM, run linux_registered_reboot.py against that backup to verify and restore baseline. Never leave the VM intentionally switched without this cleanup.

### Outgoing implementation and tagged incoming checkpoint PASS

- Full outgoing matrix finished0:32 official checksum-matched Core releases ×3 modes =96 real preflight/getnetworkinfo/file-roundtrip checks; docs/evidence/outgoing-preflight-matrix.log. Unit rejection tests pass. Preflight callback file roundtrip is explicitly separate from actual systemd proof.
- Actual nonroot PTY onlynet/proxy edit→preflight/diff→Esc no apply→Enter committed→real collected RPC value PASS. Initial PTY fixture could not traverse private /home/builder; copied only public test source to dedicated root-owned0755 directory, left private home permissions unchanged, and removed that dedicated source copy afterwards.
- Preserved selected onlynet=ipv4,ipv6,onion and proxy1 through actual VM reboot (/var/tmp/jv-initial-profile-m27a9b0f), verified new boot ID/UUID/identity/collector/chain/index/proxy, then restored baseline. Evidence outgoing-reboot-audit.log. New restart helper and managed policy changes are not in dev9.
- Found and fixed Tor incoming misclassification: HS external8333 now forwards to selected P2P+1 tagged `=onion` listener. Regtest explicitly binds loopback normal+onion ports; public networks use Core's default onion listener. Actual product Core getpeerinfo sees the real inbound onion handshake as onion. Full registered profile/TLS/QR/wallet/recovery regression PASS in incoming-onion-profile-audit.log; baseline restored and Tor reloaded to restored config. Incoming enable/disable UI remains pending.
- Public testnet4 latest observation PASS for IBD/height/header/independent tip; own broadcast remains unconfirmed0. See public-testnet4-audit.json. Previous equal-work fork recorded rather than hidden. Dedicated public nodes still running with private wallets; read-only refresh via scripts/public_testnet_audit.py --observe.


### Incoming controls checkpoint in progress

- Added finite incoming selector to M policy API/editor. Network-scoped nobind/bind overrides close external Clearnet or tagged Tor backend independently while loopback electrs P2P remains. Parser verifies exact derived bindings; actual post-restart Linux Core-owned sockets must match, otherwise existing configuration rollback runs.
- First real 32-version matrix hit an adjacent ephemeral onion port collision at26.2; private startup log proves failed bind. Updated preflight to reserve both P2P ports while choosing RPC. Retry `.state/incoming-preflight-matrix-retry.log` currently near31.1; do not infer completion until exit0.
- Actual four-mode registered Core31.1/electrs API restart and nonroot PTY pass. Initial full regression later failed on Tor circuit SOCKS timeout; bounded retries added only to read-only network requests (assertions unchanged). Second full regression passes including actual Tor RPC, TLS/QR/wallet/version recovery, and is held at **/var/tmp/jv-initial-profile-0rgsa7__** ready for reboot with incoming=tor, outgoing all, proxy1.
- Additional occupied-onion-port fault test running `.state/incoming-rollback.log`. It exposed root helper starting electrs before proving Core startup, causing120s indexer readiness wait against failed Core; fixed helper adds20s authenticated Core readiness first. Wait for current transaction/fixture restoration before installing candidate helper and redoing fault case. Then reboot held VM and run linux_registered_reboot.py against the exact backup to verify/restore baseline. Do not leave the temporary volume selected.
- All pre-existing backup WIP preserved; dev9 image unchanged. Public testnet4 read-only refresh still syncPASS, own tx confirmations0. Full RC/generic settings/physical gates remain incomplete.


### Incoming verification results / reboot in flight

- 32-version ×4-mode real incoming preflight/file-roundtrip matrix completed exit0,128 cases (244.89s). Evidence incoming-preflight-matrix.log; initial occupied-port failure retained privately and explained above.
- Full registered incoming API/TUI/owned-process-socket verification and all TLS/QR/watch-only/Tor RPC/version recovery regression passed. Evidence incoming-profile-audit.log. Initial Tor circuit timeout remains recorded; second run passed unchanged assertions with bounded transport retry.
- Injected occupied onion port: first attempt timed out waiting on the old restart helper but eventually restored original policy. Fixed helper performs authenticated Core readiness before starting electrs. Retry PASS: rejected failed/incomplete Core startup, rolled back configuration, Core recovered, original Tor-only/proxy1 selection restored. Evidence incoming-rollback-audit.log. Host cargo test also passed (hardware/matrix tests remain explicitly ignored in default run and were run separately as recorded).
- Actual VM reboot dispatched for backup /var/tmp/jv-initial-profile-0rgsa7__. Next mandatory action: once SSH responds, run sudo /opt/justverify-tests/bin/python tests/linux_registered_reboot.py /var/tmp/jv-initial-profile-0rgsa7__ from /home/builder/justverify to verify selected incoming/outgoing/identity/index persistence and restore baseline. Do not restart the generic legacy fixture.

- Incoming reboot completed PASS: new boot ID, same selected Tor-only incoming/proxy1, loopback/indexer/onion available, LAN P2P closed, chain+electrs tip and identity preserved. Baseline UUID/fstab/profile/binaries restored. Evidence incoming-reboot-audit.log. No temporary registered volume is held now.
- Found stale policy catalog network_scope metadata hardcoding four networks and omitting testnet4. Generator now inherits the already verified release networks. Runtime selection already used release support; this fixes documentation/catalog disagreement. Also fixed generator attempting to parse policy-diff.json as a numeric version on rerun.


### Resource/index/source audit complete; new image next

- Nine resource fields now use versioned help/source catalogs, bounded integer/unit handling, explicit units/ranges in TUI, Core startup logs, effective maxconnections and getnettotals uploadtarget checks.32 Core releases actual preflight PASS. Real registered API->restart->Core/electrs, ban120s and maxuploadtarget TUI change PASS; source files/evidence in resource-*.log. Fixture restores catalog files as well as baseline profile/binaries.
- Added txindex, blockfilterindex, peerblockfilters, peerbloomfilters, local REST, version-supported txospenderindex and embedded ASMAP.32-release enable/disable matrix PASS (64 starts), actual service getindexinfo completion at chain height1, indexed tx lookup/getblockfilter, protocol flags, REST and ASMAP log checks, electrs continuation PASS. Full TLS/QR/watch-only/Tor RPC/version recovery regression passed and original VM restored. Evidence auxiliary-*.log.
- Signed Core31.1/electrs regtest extended with actual Core indexes. New confirmed tx c5bf0538cb2bd11e154e1ebca657ebae8cb743d83417c480271bc55a4d41b243 has3 confirmations at height104; indexed spent-output lookup, raw tx, block filter and all three Core indexes survive restart. Evidence signed-chain-index-restart-audit.json. Earlier independent regtest results retained.
- Public testnet4 own tx50fae20278c3230093255e222d7a30e10d20fc77f68f6e07fcd7d91890ac7578 now CONFIRMED at block151996 (last observed1 confirmation), independently matched by mempool.space. Extended read-only observer verifies electrs history height and Merkle proof against Core's block header. Confirmed proof PASS in public-testnet4-audit.json. Dedicated public nodes still running; no duplicate spend/rebroadcast.
- Fixed privatebroadcast preflight incompatibility with connect=0 by using verified networkactive=0 only for that option. Refuses31.0 known IP leak and isolated regtest incompatibility.31.1 main/testnet4/signet startup PASS; actual private broadcast transport NOT TESTED. See official release-note source in DECISIONS.
- New image observer will apply selected incoming/outgoing/resource/index settings on first boot and verify persistence on second, exact Core/electrs tip, and local-only REST. Image verifier now checks every catalog and the restart helper against source. These observer/image changes are NOT RUN until the forthcoming clean-commit build. Existing backup WIP and .DS_Store preserved, excluded from image. dev9 immutable bundle unchanged; no new image yet.
- Next: commit this audited source excluding backup WIP; build a clean archive in a separate Linux builder directory using verified /home/builder/artifacts/base.img.xz, bitcoin-31.1 and /home/builder/electrs/target/release/electrs; tag dev10. Then read-only image verify, disposable two-boot observer, checksums/source/manifest/install recovery documentation. Remaining full-policy semantics/backup/update/reproducibility/signing/physical Pi/mobile/24h gates mean no RC completion claim.

### Resume checkpoint — historical indexing fix and dev10 boot failure

- Clean application9ec13c8 built dev10 immutable image; read-only verifier PASS. Image SHA256621c6bfaed51b373147fa1aa86b777a99afc9035ad057f3b34bdaa32cc642fe9. First actual disposable boot PASS; second boot settings/chain/index/wallet persistence passed but Tor SOCKS circuit timed out: overall FAIL, preserved .state/dev10-image-probe.log/private failure disks. No RC claim.
- Observer now explicitly waits for current-boot Tor bootstrap100 before bounded circuit test; overall300s unchanged. Original failure did not record bootstrap progress, so cause is not proven. Separate pristine dev10b experiment running session63178/log .state/dev10b-image-probe.log. Preparation partition-node race fixed via udev settle/bounded presence check. No image application modified.
- Actual umbrel-apps deployment7345dcb4 audited, pin/files recorded. Found finite upload limit can block historical electrs downloads on previous ordinary P2P backend. New source uses loopback P2P+2 whitebind download,noban and electrs matching endpoint, validates owned sockets, refuses finite cap on legacy profile lacking metadata. Real native31.1 historical negative/positive test PASS; 32-release Linux matrix running .state/historical-index-matrix-retry.log (initial attempt only failed missing evidence directory before any Core execution).
- Registered VM backend integration/reboot preparation running session4204 .state/backend-profile-audit.log. If READY FOR REBOOT, read exact backup path, reboot, run registered_reboot fixture and restore baseline. Do not interrupt cleanup or use legacy standalone fixture.
- New backend source/tests not yet committed or built into image. Next: collect32-release and registered/reboot evidence; commit selectively preserving backup WIP; clean dev11 build/read-only/two-boot validation. Remaining broader S0–S4 software and physical gates still apply.

- Backend32-release matrix completed PASS (all65 actual blocks, actual expected upload refusal and fresh successful backend index). Registered full profile/API/TUI/Tor RPC/wallet/TLS/QR/recovery suite PASS. Actual reboot PASS with same data/identity, Core/electrs tip, download+noban backend and LAN isolation; baseline restored. Evidence backend-profile-audit.log and backend-reboot-audit.log.
- Source commit11c8419 excludes pre-existing backup WIP. Clean archive compiled successfully in /home/builder/justverify-dev11. dev11 image build running .state/dev11-build.log. dev10b failed even after bootstrap100 (not merely readiness observer timing), evidence image-dev10b-data-probe.json; new observer preserves Tor journal privately for diagnostics. No blind retry or success claim.

- dev11 pristine image built and read-only verified PASS, host/VM SHA256 match160b202f895b10f15aa9e9ca33bead39b950f813c1ed3cfdffff2fcc8f168f74. App build11c8419, observerc9b05e9. Fresh two-boot copy .state/vm/probe-dev11-data.img + image-data-14.qcow2 in preparation/launch session44011; log .state/dev11-image-probe.log. Only these private test copies contain test identity, never distribute.
- Public read-only observation now confirms own testnet4 tx6 times at height152001, CoreIBDfalse and electrs/Core/independent exact tip match. No new spend or rebroadcast. Evidence updated.

### dev11 install/reboot PASS; final audit bundle next

- Actual pristine dev11 disposable image test finished PASS, first34.96s/second24.95s. Core31.1/electrs0.11.1/Tor, new backend exact privileges/LAN isolation,20 selected settings/all3indexes, identity/data/wallet/PSBT, authenticated onion RPC, packaged browser TUI and QR verified through actual reboot. Evidence image-dev11-data-probe.json. QEMU shut down normally; private image/data14 must never be distributed. No claim of Pi firmware/mobile completion or universal Tor circuit reliability; dev10/dev10b failures retained.
- Read-only public testnet4 observation height152001, IBDfalse, equal Core/electrs/independent tip and6 confirmations. Regtest signed tx3 confirmations and32-version historical-index matrix remain PASS. VM baseline restored and active; dedicated public nodes stay running, no duplicate spend.
- Additional S4 preparation: locked Cargo metadata327 packages including app;326 external packages license inventory/text collection under docs/licenses/rust. Some registry packages omit license texts/VCS provenance; explicit gaps remain, and OS/Python/native/source-offer/legal review is not complete.
- Remaining work: full policy semantic coverage, preserved backup WIP review/real restore, atomic system update/last-known-good, reproducible OS/wheel build, full notices/trusted signing, physical Pi5/media/mobile/separate LAN/camera/24h. Do not report S0–S4 or normal-operation confirmation complete. Resume from these gates without deleting any tests or baseline data.

- Post-bundle review found policy catalog display defect: Core31 limitclustercount default contained `64, maximum: 64`. Generator now separates default64 from retained full help text; all32 catalog scalar defaults validated, runtime maximum64 unchanged. dev11 immutable artifact/bundle retained, source/catalog fix requires fresh dev12 image assembly and verification. This is not a prior runtime consensus/mempool failure.

- dev12 image assembly started from clean a87289a catalog/source; Rust src/Cargo.lock were byte-compared to dev11 and the same verified11c8419 application binary reused (no Rust behavior change). Installed observer770b8e8 adds actual policy-service default64 assertion. Build→read-only verify→prepare pipeline session86972/log .state/dev12-build-verify-prepare.log; next copy /var/tmp/jv-virt-probe-dev12.img to new host private file and boot with new data15 only after pipeline exit0. dev11 host artifacts preserved; duplicate builder dev11 compressed image/preboot scratch removed after verified host retention to keep disk space.
- License follow-up: r-efi's exact VCS AUTHORS includes its MIT grant, collected both versions.323/326 all-platform external crate notices collected; ARM64 default runtime/build closure262/262 texts present. OS/Python/native/source-offer/legal review remains separate.
- Reviewed existing backup WIP without activating/mutating it; concrete blockers and next safe implementation in docs/BACKUP_REVIEW.md (canonical privileged config validation, versioned policy path, data UUID/downgrade guard, concurrent web/config writes and post-restore health). This is software work, not a user hardware blocker.

- dev12 build/read-only verifier/preparation completed exit0. Pristine SHA256902975da8186fb27f278eee46236e0ccb70e64c939a4a1c59dba7228551c2c46 matches builder/host. Test copy transfer/boot running session69037: .state/vm/probe-dev12-data.img + new image-data-15.qcow2, log .state/dev12-image-probe.log. Preserve older failure/PASS records. Assemblya87289a, Rust binary11c8419, observer770b8e8. No image boot PASS until two actual records are present.

- dev12 final image two-boot PASS recorded; first/second elapsed [28.879283, 55.73913]. Default metadata64 confirmed through installed policy API. Next: freeze final source archive/manifest/checksums, retaining all earlier bundles and failures.
