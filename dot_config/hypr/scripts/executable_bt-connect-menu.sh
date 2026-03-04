#!/bin/sh

get_bt_devices() {
  # Get paired devices
  paired="$(bluetoothctl devices Paired)"

  # Get connected device MACs only
  connected_macs="$(bluetoothctl devices Connected | awk '{print $2}')"

  printf "%s\n" "$paired" | while read -r _ mac name; do
    # Determine connection state by membership
    if printf "%s\n" "$connected_macs" | grep -qx "$mac"; then
      state="●"
    else
      state="○"
    fi

    # Format for fuzzel
    printf '%s\t%s;%s;%s\n' "$state $name" "$state" "$name" "$mac"
  done
}

notify() {
  notify-send -t 2000 -h string:synchronous:bt-connect "Bluetooth" "$1"
}

devices="$(get_bt_devices)"

[ -z "$devices" ] && {
  notify "No paired Bluetooth devices"
  exit 0
}

IFS=';' read -r state name mac <<EOF
$(printf "%s" "$devices" | \
  fuzzel --dmenu --with-nth=1 --accept-nth=2 \
    --prompt="Bluetooth connection" --minimal-lines -R)
EOF

[ -z "$state" ] && exit 0

if [ "$state" = "●" ]; then
  notify "Disconnecting: $name"

  if bluetoothctl disconnect "$mac"; then
    notify "Disconnected: $name"
  else
    notify "Failed to disconnect: $name"
  fi
else
  notify "Trying to connect: $name"

  if bluetoothctl connect "$mac"; then
    notify "Connected: $name"
  else
    notify "Failed to connect: $name"
  fi
fi
