#!/usr/bin/env bash
set -euo pipefail

DEVICE_ID=${DEVICE_ID:-"5b8e6c0ebe914a7588556afa24402dc9"}
KDE_DEVICE_LIST="$(kdeconnect-cli -a --id-only)"
STATE_FILE="/tmp/kdeconnect_state_$DEVICE_ID"

# Check if device is connected
if grep -Fxq -- "$DEVICE_ID" <<<"$KDE_DEVICE_LIST"; then
  current_state="connected"
else
  current_state="disconnected"
fi

# Get last state
last_state="disconnected"
if [[ -f $STATE_FILE ]]; then
  last_state=$(< $STATE_FILE)
fi

# Send notification
case "$last_state:$current_state" in
  disconnected:connected)
    notify-send -t 3000 -h string:synchronous:kdeconnect "KDE Connect" "󰄬 Connected"
  ;;
  
  connected:disconnected|disconnected:disconnected)
    notify-send -t 20000 -h string:synchronous:kdeconnect "KDE Connect" "󰅖 Not connected!"
  ;;
esac

# Save the current state to file
printf '%s' "$current_state" > "$STATE_FILE"
