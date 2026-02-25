#!/bin/bash

notify() {
  notify-send "Sound" "$1"
}

while true; do
  players="$(playerctl -a metadata \
    -f "{{emoji(status)}} [{{playerName}}] {{default(artist, title)}}\t{{playerName}}" \
  )"

  if [[ -z $players ]]; then
    notify "No active players"
    break
  fi

  players="${players//▶️/}"
  players="${players//⏸️/}"

  selected=$(printf "$players" \
    | fuzzel -d --with-nth=1 --accept-nth=2 \
    --hide-prompt --mesg="Toggle play-pause" \
    --minimal-lines -R
    )

  if [ -z "$selected" ]; then
    break
  fi

  playerctl -p "$selected" play-pause
  sleep 0.1  # This makes sure playerctl has time to react when reading the status again at the top 
done
