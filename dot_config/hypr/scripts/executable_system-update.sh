#!/bin/sh
set -eu

notify() {
  echo "System update: $1"
  notify-send -h string:synchronous:sys-update -t 5000 " System Update" "$1"
}

error_exit() {
  echo "System update error: $1"
  notify "Failed: $1"
  mpv --really-quiet --no-video ~/.config/hypr/audio/error.ogg
  exit 1
}

if ! pgrep -x hyprpolkitagent >/dev/null 2>&1; then
  error_exit "hyprpolkitagent is not running."
fi

notify "Starting system update..."

# Run yay upgrade using pkexec for escalation
if ! yay -Syu --noconfirm --sudo pkexec; then
    error_exit "System"
fi

notify "System packages updated."

if command -v flatpak >/dev/null 2>&1; then
    notify "Starting Flatpak update..."
    flatpak update -y || error_exit "Flatpak"
fi

notify "All complete"
mpv --really-quiet --no-video ~/.config/hypr/audio/cute-level-up.ogg
