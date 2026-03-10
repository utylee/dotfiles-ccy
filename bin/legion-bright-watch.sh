#!/usr/bin/env bash
set -euo pipefail

# Legion Go / AMD backlight watcher for KDE/Wayland
# Goal:
#   - Keep bright locally
#   - If RustDesk has an *active inbound* RustDesk session -> dim immediately
#   - RustDesk disconnected -> bright
#
# Why this version:
#   - Your previous is_rustdesk_connected() matched *any* rustdesk ESTABLISHED socket,
#     including background/outbound connections, so it could stay "connected" forever.
#   - Boot can restore brightness=1; we force an initial bright that is NOT affected
#     by any RustDesk heuristics in other scripts.

BACKLIGHT_DEV="${BACKLIGHT_DEV:-amdgpu_bl1}"
BRIGHT_PCT="${BRIGHT_PCT:-65}"
DIM_PCT="${DIM_PCT:-1}"

LOCK="${XDG_RUNTIME_DIR:-/tmp}/legion-bright-watch.lock"
exec 9>"$LOCK"
flock -n 9 || exit 0

# Ensure we have the right user session id even under systemd --user
: "${XDG_SESSION_ID:=$(loginctl list-sessions --no-legend | awk -v u="$USER" '$3==u {print $1; exit}')}"

state="unknown"

BOOT_GUARD="${BOOT_GUARD:-6}"          # seconds to force bright after login
DIM_AFTER_IDLE="${DIM_AFTER_IDLE:-3}"  # seconds of idle (while RustDesk session is active) before dimming
conn_counter=0
CONN_STABLE="${CONN_STABLE:-2}"

set_pct() {
  local pct="$1"
  brightnessctl -d "$BACKLIGHT_DEV" set "${pct}%" >/dev/null 2>&1 || true
}

is_rustdesk_connected() {
  # Only treat as "remote session active" when there is an inbound ESTABLISHED socket
  # on RustDesk's local listen port (your confirmed case: sport=21118) AND owned by rustdesk.
  #
  # This avoids false positives from RustDesk's background/outbound connections.
  ss -Hntp state established "( sport = :21118 )" 2>/dev/null | grep -q 'users:(("rustdesk"'
}


set_dim() {
  [[ "$state" == "dim" ]] && return
  set_pct "$DIM_PCT"
  state="dim"
}

set_bright() {
  [[ "$state" == "bright" ]] && return
  set_pct "$BRIGHT_PCT"
  state="bright"
}

# --- Boot/login sync: force bright once (bypasses any other heuristics) ---
set_pct "$BRIGHT_PCT"
state="bright"

while true; do
  if ss -Hnt state established "( sport = :21118 )" | grep -q .; then
    brightnessctl -d amdgpu_bl1 set 1% >/dev/null
  else
    brightnessctl -d amdgpu_bl1 set 65% >/dev/null
  fi
  sleep 1
done

# while true; do
#   # Guard window after login: keep bright even if IdleHint starts as "yes"
#   if (( BOOT_GUARD > 0 )); then
#     ((BOOT_GUARD--))
#     set_bright
#     sleep 1
#     continue
#   fi

#   # RustDesk connected => dim, otherwise bright.
#   # Small debounce avoids flicker if the socket appears/disappears briefly.
#   if is_rustdesk_connected; then
#     ((conn_counter++))
#     if (( conn_counter >= CONN_STABLE )); then
#       set_dim
#     fi
#   else
#     conn_counter=0
#     set_bright
#   fi

#   sleep 1
# done
