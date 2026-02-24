#!/bin/sh
set -eu

notify() {
  echo "Alt System Update: $1"
  notify-send -h string:synchronous:alt-sys-update -t 5000 " Alt System Update" "$1"
}

error_exit() {
  echo "Alt System update error: $1"
  notify "Update failed: $1"
  mpv --really-quiet --no-video ~/.config/hypr/audio/error.mp3
  exit 1
}

# --- hyprpm update ---
notify "Hyprland packages (hyprpm)..."
if ! hyprpm update; then
    error_exit "hyprpm update failed"
fi

# --- fisher update ---
notify "Fish plugins (fisher)..."
if ! fish -c "fisher update"; then
    error_exit "Fisher update failed"
fi

notify "All complete"
mpv --really-quiet --no-video ~/.config/hypr/audio/cute-level-up.mp3
