#!/bin/bash

notify() {
  notify-send -t 8000 -h string:synchronous:rmpc-rate-song "$1" "$2"
}

rating_str() {
  case "$1" in
    0) echo "Dislike" ;;
    1) echo "Neutral" ;;
    2) echo "Like" ;;
    *) echo "" ;;
  esac
}

# Get current song file
song_file="$(rmpc song | jq -r '.file')"

# Notify if not found
if [ -z "$song_file" ]; then
  notify "RMPC" "No song playing"
  exit 0
fi

# Get current rating (defaults to Neutral if no rating)
cur_rating_num="$(rmpc sticker list "$song_file" | jq -r '.like // 1')"
cur_rating_str="$(rating_str $cur_rating_num)"

# Build rating menu
rating_options="[l] 󰔓;2
[d] 󰔑;0
[n] ;1"
menu=$(printf '%s\n' "$rating_options" | while read -r p; do
  rating_num=$(echo "$p" | cut -d';' -f2)
  if [ "$rating_num" -eq "$cur_rating_num" ]; then
    state="●"
  else
    state="○"
  fi

  printf "%s %s\n" "$state" "$p"
done)

# Fuzzel
selected_rating_num=$(echo -e "$menu" | fuzzel -dR --minimal-lines \
  --auto-select --placeholder="Rate song" \
  --nth-delimiter=';' --with-nth=1 --accept-nth={2})
selected_rating_str=$(rating_str "$selected_rating_num")

# Exit if none chosen
[ -z "$selected_rating_str" ] && exit 0

# Get song info
{
  IFS= read -r artist
  IFS= read -r track
} <<EOF
$(rmpc song 2>/dev/null | jq -r '.metadata.artist // "", .metadata.title // ""')
EOF

# Notify
body="󰠃 $artist
 $track"
if [ $cur_rating_str == $selected_rating_str ]; then
  title="Rating unchanged: $selected_rating_str"
else
  title="Rating: $selected_rating_str"
  # Set rating
  rmpc sticker set "$song_file" "like" "$selected_rating_num"
fi
notify "$title" "$body"