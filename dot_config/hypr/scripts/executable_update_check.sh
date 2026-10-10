#!/bin/bash

audio_src="$HOME/.config/hypr/audio/update-notif.ogg"

# Get update amount
udpate_amnt=$(checkupdates | wc -l)

# Exit, if there are less than 50 updates
[ $udpate_amnt -lt 50 ] && exit 0

# Notify of updates
notify-send -t 10000 -h string:synchronous:update-notif -i system-software-update-symbolic \
    "Update recommended!" "󰏖 Packages: $udpate_amnt"
mpv --really-quiet --no-video "$audio_src"
