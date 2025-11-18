#!/usr/bin/env bash

status=$(rfkill list bluetooth | grep -i "Soft blocked" | awk '{print $3}' | head -n1)

if [ "$status" = "yes" ]; then
    rfkill unblock bluetooth
    notify_text="Enabled"
else
    rfkill block bluetooth
    notify_text="Disabled"
fi

notify-send -t 2000 -h string:synchronous:bluetooth-toggle "Bluetooth" "$notify_text"
