#!/bin/bash


notify() {
    title="$1"
    body="$2"
    notify-send -t 5000 -h string:synchronous:mpc-picker "$title" "$body"
}

get_artists() {
    mpc list artist | sort -u
}

get_artist_albums() {
    artist="$1"
    mpc list album artist "$artist" | sort -u
}

get_song_count() {
    songs="$1"
    echo "$songs" | wc -l
}

play_songs() {
    songs="$1"

    # Exit with error if no songs are given
    [ -z "$songs" ] && exit 1

    mpc clear > /dev/null
    echo "$songs" | mpc add > /dev/null
    mpc play > /dev/null
}

pick_playlist() {
    # Get playlist names
    playlists=$(mpc lsplaylists)

    # Prompt the user to select a playlist
    playlist=$(echo "$playlists" | fuzzel --dmenu --prompt="Playlist:")

    # Exit if no playlist is selected
    [ -z "$playlist" ] && exit 0

    echo "$playlist"
}

pick_artist() {
    # Choose artist
    artist=$(echo "$(get_artists)" | fuzzel --dmenu --prompt="Artist:")

    # Exit if no artist is selected
    [ -z "$artist" ] && exit 0

    echo "$artist"
}

get_artist_songs() {
    artist="$1"

    # Exit with an error if no artist is selected
    [ -z "$artist" ] && exit 1

    # Get songs by artist
    mpc find artist "$artist"
}

get_album_songs() {
    album="$1"

    # Exit with an error if no album is selected
    [ -z "$album" ] && exit 1

    # Get songs by album
    mpc find album "$album"
}

gef_playlist_songs() {
    playlist="$1"

    # Exit with an error if no playlist is selected
    [ -z "$playlist" ] && exit 1

    # Get playlist songs
    mpc -f "%file%" playlist "$playlist"
}

pick_artist_album() {
    # Choose artist
    artist="$1"

    # Exit if no artist is selected
    [ -z "$artist" ] && exit 0

    # Choose album
    album=$(echo "$(get_artist_albums "$artist")" | fuzzel --dmenu --prompt="Album:")

    # Exit if no album is selected
    [ -z "$album" ] && exit 0

    echo "$album"
}


# List options
options="artist
album
playlist"

# Select
selected=$(echo -e "$options" | fuzzel -d --prompt="Change MPC Queue" --minimal-lines -R)

# Exit if no selection
[ -z "$selected" ] && exit 0

if [  "$selected" = "artist" ]; then
    artist=$(pick_artist)
    songs=$(get_artist_songs "$artist")
elif [ "$selected" = "album" ]; then
    artist=$(pick_artist)
    album=$(pick_artist_album "$artist")
    songs=$(get_album_songs "$album")
elif [ "$selected" = "playlist" ]; then
    playlist=$(pick_playlist)
    songs=$(gef_playlist_songs "$playlist")
fi

play_songs "$songs"

song_count=$(get_song_count "$songs")
if [ "$selected" = "artist" ]; then notify "Queued Artist" "󰠃 $artist\n $song_count"
elif [ "$selected" = "album" ]; then notify "Queued Album" "󰀥 $album\n $song_count"
elif [ "$selected" = "playlist" ]; then notify "Queued Playlist" "󰲹 $playlist\n $song_count"
fi