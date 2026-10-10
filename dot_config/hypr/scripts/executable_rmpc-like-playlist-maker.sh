#!/bin/bash

# Creates a playlist that contains all the liked songs
playlist_name="Liked"
playlist_file_path="$HOME/.config/mpd/playlists/$playlist_name.m3u"

# Clear playlist
echo "" > "$playlist_file_path"

mpc listall | while read track_path; do
    rating=$(rmpc sticker list "$track_path" | jq -r '.like // 1')
    if [ "$rating" -ne 2 ]; then
        continue
    fi

    # Add track to playlist
    echo "$track_path" >> "$playlist_file_path"
    echo "Added: $track_path"
done

count=$(mpc playlist $playlist_name | wc -l)

notify-send -t 8000 -h string:synchronous:rmpc-like-playlist "RMPC: $playlist_name Playlist" "Track count: $count"
echo "Added $count tracks to \"$playlist_name\" playlist"