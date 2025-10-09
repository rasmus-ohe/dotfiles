#!/usr/bin/env sh
# wg-off.sh — turn off WireGuard via NetworkManager
# Usage: wg-off.sh <session|permanent>

set -u

usage() {
  echo "usage: ${0##*/} <session|permanent>" >&2
  exit 2
}

# Require nmcli
command -v nmcli >/dev/null 2>&1 || {
  echo "nmcli not found. Install NetworkManager." >&2
  exit 127
}

mode="${1-}"
case "$mode" in
  session|permanent) ;;
  "") usage ;;
  *) echo "invalid mode: $mode" >&2; usage ;;
esac

# Bring down all active WireGuard connections
nmcli -t -f NAME,TYPE con show --active \
| awk -F: '$2=="wireguard"{print $1}' \
| while IFS= read -r c; do
    [ -n "$c" ] || continue
    nmcli con down "$c" >/dev/null 2>&1 || true
  done

if [ "$mode" = "permanent" ]; then
  # Disable autoconnect for all WireGuard profiles
  nmcli -t -f NAME,TYPE con show \
  | awk -F: '$2=="wireguard"{print $1}' \
  | while IFS= read -r c; do
      [ -n "$c" ] || continue
      nmcli con modify "$c" connection.autoconnect no >/dev/null
    done
fi

echo "WireGuard connections turned off ($mode)."
