#!/bin/bash

notify-send -t 10000 "⏰ Hourly Notification" "It's $(date '+%H:%M')" -u "low"
mpv --really-quiet --no-video ~/.config/hypr/audio/hourly.ogg
