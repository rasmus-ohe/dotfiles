#!/bin/bash

cache_dir="/tmp/rmpc-art-cache"

# Remove old cache (older than 1 day)
find "$cache_dir" -type f -mtime +1 -delete

# Playing icon
if [ "$(playerctl status)" == "Playing" ]; then status=""; else status=""; fi

# Metadata
player="$(playerctl metadata --format '{{uc(playerName)}}')"
artist="$(playerctl metadata --format '{{artist}}')"
track="$(playerctl metadata --format '{{title}}')"
album="$(playerctl metadata --format '{{album}}')"
art_url="$(playerctl metadata mpris:artUrl)"


body="󰠃 $artist\n $track"
# Add album if available
if [ -n "$album" ]; then body="$body\n󰀥 $album"; fi

# Resolve album art to a local path notify-send can use
icon=""
case "$art_url" in
    file://*)
        icon="${art_url#file://}"
        ;;
    http://*|https://*)
        mkdir -p "$cache_dir"
        hash="$(printf '%s' "$art_url" | md5sum | cut -d' ' -f1)"
        cache="$cache_dir/$hash.jpg"
        if [ -f "$cache" ] || curl -s -o "$cache" "$art_url"; then
            icon="$cache"
        fi
        ;;
esac

notify-send -t 15000 -h string:synchronous:playerctl-notify \
    ${icon:+-i "$icon"} \
    "$player" "$body"
