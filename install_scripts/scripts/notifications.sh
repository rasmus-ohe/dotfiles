#!/bin/bash

# Icon Naming Specification: https://specifications.freedesktop.org/icon-naming/latest/

packages=(
  libnotify # Notifications (notify-send)
  swaync # Notification daemon
  battery-notify  # Battery status notifier (inc. bluetooth devices)
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"