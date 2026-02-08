#!/bin/sh

get_device ()
{
  # Get a list of devices
  raw_devices="$(ratbagctl list)"

  # Exit if no devices are found
  [ -z "$raw_devices" ] && exit 1

  # Get the number of devices found
  device_count="$(printf "%s\n" "$raw_devices" | wc -l)"

  # If only one device is found, use it without prompting the user
  if [ "$device_count" -eq 1 ]; then
    DEVICE="$(printf "%s\n" "$raw_devices" | awk -F: '{print $1}')"

  else # If multiple devices are found, prompt the user to select one
    menu="$(printf "%s\n" "$raw_devices" | awk -F: '
      {
        id=$1
        name=$2
        sub(/^[ \t]+/, "", name)
        print name " | " id
      }
    ')"

    choice="$(printf "%s\n" "$menu" \
      | fuzzel --dmenu --prompt="Mouse device: ")"

    [ -z "$choice" ] && exit 0

    DEVICE="$(printf "%s" "$choice" | awk -F' \\| ' '{print $2}')"
  fi

  # Return the selected device
  echo "$DEVICE"
}

function choose_profile () {
  # Parameters
  DEVICE="$1"

  # Get a list of profiles for the selected device
  profiles="$(ratbagctl "$DEVICE" info | awk '
    /^Profile [0-9]+:/ {
      idx=$2
      sub(":", "", idx)

      active = ($0 ~ /\(active\)/) ? " (active)" : ""
      print idx active
    }
  ')"

  # Prompt the user to select a profile
  choice="$(printf "%s\n" "$profiles" | fuzzel --dmenu --prompt="Mouse profile: ")"

  # Exit if no profile is selected
  [ -z "$choice" ] && exit 0

  # Extract the profile index from the user's choice
  profile="$(printf "%s" "$choice" | awk '{print $1}')"

  # Return the selected profile index
  echo "$profile"
}

DEVICE="$(get_device)"
DEVICE_NAME="$(ratbagctl "$DEVICE" info | head -n 1 | awk -F' - ' '{print $2}')"

PROFILE="$(choose_profile "$DEVICE")"

notify-send "$DEVICE_NAME" "Profile set to $PROFILE"
ratbagctl "$DEVICE" profile active set "$PROFILE"
