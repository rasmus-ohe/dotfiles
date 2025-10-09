#!/usr/bin/env sh
# wg-use.sh — switch to a WireGuard profile via NetworkManager
# Usage:
#   wg-use.sh <NAME> [session]
#   wg-use.sh           # list available WireGuard profiles

set -eu

usage() {
  echo "usage: ${0##*/} <NAME> [session]" >&2
  exit 2
}

# Require nmcli
command -v nmcli >/dev/null 2>&1 || {
  echo "nmcli not found. Install NetworkManager." >&2
  exit 127
}

# List profiles if no args
if [ $# -eq 0 ]; then
  nmcli -t -f NAME,TYPE con show | awk -F: '$2=="wireguard"{print $1}'
  exit 0
fi

name="$1"
mode="${2-}"

# Verify connection exists and is wireguard
if ! nmcli -t -f NAME,TYPE con show | grep -q "^$name:wireguard$"; then
  echo "No such WireGuard connection: $name" >&2
  exit 1
fi

# Bring down all active WG connections
nmcli -t -f NAME,TYPE con show --active \
| awk -F: '$2=="wireguard"{print $1}' \
| while IFS= read -r c; do
    [ -n "$c" ] || continue
    nmcli con down "$c" >/dev/null 2>&1 || true
  done

case "$mode" in
  "" )
    # Default: permanent
    for c in $(nmcli -t -f NAME,TYPE con show | awk -F: '$2=="wireguard"{print $1}'); do
      nmcli con modify "$c" connection.autoconnect no
    done
    nmcli con modify "$name" connection.autoconnect yes connection.autoconnect-priority 10
    ;;
  session )
    # Do not touch autoconnect flags
    ;;
  * )
    echo "invalid mode: $mode" >&2
    usage
    ;;
esac

# Bring target up
nmcli con up "$name"

echo "WireGuard connection '$name' is now active (${mode:-permanent})."
