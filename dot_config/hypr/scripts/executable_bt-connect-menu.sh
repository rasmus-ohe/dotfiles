#!/bin/sh

get_bt_devices() {
  bt-device -l | tail -n +2 | while IFS= read -r line; do
    name=${line% (*}
    mac=${line##*(}
    mac=${mac%)}
    
    # Check connection state
    if bt-device -i "$mac" 2>/dev/null | grep -q "Connected: 1"; then
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

# Get all paired bluetooth devices
devices=$(get_bt_devices)

# Exit if no devies have been paired
[ -z "$devices" ] && {
  notify "No paired Bluetooth devices"
  exit 0
}

# User selects a device to (dis)connect
IFS=$';' read -r state name mac < <(
  printf "%s" "$devices" | \
  fuzzel --dmenu --with-nth=1 --accept-nth=2 \
    --prompt="Bluetooth connection" --minimal-lines -R
)

[ -z "$state" ] && exit 0

# Check the state
if [ "$state" = "●" ]; then
  notify "Disconnecting: $name"

  # Currently connected → disconnect
  if bluetoothctl disconnect "$mac"; then
    notify "Disconnected: $name"
  else
    notify "Failed to disconnect: $name"
  fi
else
  notify "Trying to connect: $name"

  # Currently disconnected → connect
  if bluetoothctl connect "$mac"; then
    notify "Connected: $name"
  else
    notify "Failed to connect: $name"
  fi
fi
