우분투 설정 백업 (날짜: YYYY-MM-DD)

포함된 항목:
1. /etc/systemd/system/x11vnc.service
   → x11vnc VNC 자동 시작 서비스

2. ~/.config/pulse/client.conf
   ~/.config/pulse/default.pa (있을 경우)
   → HDMI 오디오 기본 장치 고정

3. /etc/gdm3/custom.conf
   → GDM 설정 (Wayland 비활성화 → Xorg 강제, 자동 로그인 utylee 계정)

참고 기록:
- 커널 버전: 6.8.0-65-generic (Ubuntu OEM 커널)
- HDMI 오디오 문제 해결된 커널 버전임
- 설치 명령어:
    sudo apt update
    sudo apt install linux-oem-22.04

복원 방법:
1. VNC 서비스 복원
   sudo cp x11vnc.service /etc/systemd/system/
   sudo systemctl daemon-reexec
   sudo systemctl enable --now x11vnc.service

2. 오디오 설정 복원
   cp pulse-config/* ~/.config/pulse/
   systemctl --user restart pulseaudio

3. GDM 설정 복원
   sudo cp gdm3-custom.conf /etc/gdm3/custom.conf
   sudo systemctl restart gdm3

재부팅 후 점검 체크리스트:
- pactl info | grep "Default Sink" → HDMI 잡혔는지 확인
- systemctl status x11vnc.service → VNC 자동 실행 확인
- 로그인 화면 없이 바로 Xorg + 자동로그인 되는지 확인



#####참고########
백업했던 방법
mkdir -p ~/temp/ubuntu-backup-$(date +%Y%m%d)/pulse-config

# VNC 서비스 백업
sudo cp /etc/systemd/system/x11vnc.service ~/temp/ubuntu-backup-$(date +%Y%m%d)/x11vnc.service

# PulseAudio 설정 백업 (수정한 파일만)
cp ~/.config/pulse/client.conf ~/temp/ubuntu-backup-$(date +%Y%m%d)/pulse-config/ 2>/dev/null
cp ~/.config/pulse/default.pa ~/temp/ubuntu-backup-$(date +%Y%m%d)/pulse-config/ 2>/dev/null

