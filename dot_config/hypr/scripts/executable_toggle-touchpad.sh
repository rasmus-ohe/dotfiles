#!/usr/bin/env bash

device="msft0001:00-06cb:ce44-touchpad"
status_file="/tmp/touchpad_enabled"

# Initialize status file if it doesn't exist
if [ ! -f "${status_file}" ]; then
    echo "1" > "${status_file}"
fi

enabled=$(cat "$status_file")

if [ "$enabled" = "1" ]; then
    status="🚫 Disabled"
    hyprctl keyword device[$device]:enabled 0
    echo "0" > "${status_file}"
else
    status="✔️ Enabled"
    hyprctl keyword device[$device]:enabled 1
    echo "1" > "${status_file}"
fi

notify-send  -t 2000 -h string:synchronous:touchpad-toggle "Touchpad" "${status}"