#!/bin/sh

# set -eu

notify() {
  echo "System Update: $1"
  notify-send -h string:synchronous:alt-sys-update -t 5000 " System Update" "$1"
}

error_exit() {
  echo "System update error: $1"
  notify "Update failed: $1"
  mpv --really-quiet --no-video ~/.config/hypr/audio/error.ogg
  exit 1
}

# --- hyprpm update ---
notify "System..."
if ! yay -Syu --noconfirm --needed --disable-download-timeout; then
    error_exit "System update failed"
fi

# --- fisher update ---
notify "Flatpak..."
if ! fish -c "flatpak update -y"; then
    error_exit "Flatpak update failed"
fi

notify "All complete"
mpv --really-quiet --no-video ~/.config/hypr/audio/cute-level-up.ogg

