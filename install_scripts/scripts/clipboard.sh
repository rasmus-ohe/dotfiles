#!/bin/bash

packages=(
  wl-clipboard  # Wayland clipboard
  wl-clip-persist  # Clipboard persistence
  cliphist  # Clipboard history manager
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"