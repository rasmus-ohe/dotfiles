#!/usr/bin/env bash

capacity="$(< /sys/class/power_supply/BAT0/capacity)"
status="$(< /sys/class/power_supply/BAT0/status)"

if [ "$status" = "Charging" ]; then
  symbol="󰂄"
elif [ "$capacity" -ge 50 ]; then
  symbol="󰂂"
else
  symbol="󰁺"
fi

time_str="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "time" | xargs)"
if [ "$status" = "Charging" ]; then
  remove_prfx="time to full: "
else
  remove_prfx="time to empty: "
fi
status="${status} [${time_str#"$remove_prfx"} left]"

notify-send -t 3000 -h string:synchronous:battery-capacity "$symbol $capacity%" "$status"

