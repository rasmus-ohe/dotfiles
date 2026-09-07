#!/bin/bash


# Get playlist names
playlists=$(mpc lsplaylists)

# Prompt the user to select a playlist
playlist=$(echo "$playlists" | fuzzel --dmenu --prompt="Playlist:")

# Exit if no playlist is selected
if [ -z "$playlist" ]; then
    exit 0
fi

# Play the selected playlist
mpc clear
mpc load "$playlist"
mpc play

notify-send -t 5000 -h string:synchronous:mpc "Queue Playlist" "$playlist"