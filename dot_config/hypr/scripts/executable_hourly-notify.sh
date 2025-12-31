#!/bin/bash

notify-send -t 60000 "⏰ Hourly Notification" "It's $(date '+%H:%M')"
mpv --really-quiet --no-video ~/.local/share/hourly-notify/hourly.mp3
