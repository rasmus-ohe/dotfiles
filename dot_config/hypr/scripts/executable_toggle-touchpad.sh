#!/usr/bin/env bash

device=" msft0001:00-06cb:ce44-touchpad"

state=$(hyprctl getoption "input:$device:enabled" | grep -oP '(?<=int: )\d')

if [ "$state" = "1" ]; then
    hyprctl keyword "input:$device:enabled" 0
else
    hyprctl keyword "input:$device:enabled" 1
fi
