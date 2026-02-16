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

    # Display column (state + name) + machine column (MAC)
    printf "%s %s\t%s\n" "$state" "$name" "$mac"
  done
}

notify() {
  notify-send -t 2000 -h string:synchronous:bt-connect "Bluetooth" "$1" 
}


devices=$(get_bt_devices)

[ -z "$devices" ] && {
  notify-send -t 2000 -h string:synchronous:bt-connect "No paired Bluetooth devices"
  exit 0
}

selected=$(printf "%s\n" "$devices" | \
           fuzzel --dmenu --with-nth=1 --prompt="Bluetooth")

[ -z "$selected" ] && exit 0

# Extract fields
selected_label=${selected%%$'\t'*}
selected_mac=${selected#*$'\t'}

# Parse state + name
state=${selected_label%% *}
device_name=${selected_label#? }

if [ "$state" = "●" ]; then
  notify "Disconnecting: $device_name"

  # Currently connected → disconnect
  if bluetoothctl disconnect "$selected_mac" > /dev/null 2>&1; then
    notify "Disconnected: $device_name"
  else
    notify "Failed to disconnect: $device_name"
  fi
else
  notify "Trying to connect: $device_name"

  # Currently disconnected → connect
  if bluetoothctl connect "$selected_mac" > /dev/null 2>&1; then
    notify "Connected: $device_name"
  else
    notify "Failed to connect: $device_name"
  fi
fi
