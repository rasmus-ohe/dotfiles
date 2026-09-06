#!/bin/bash

packages=(
  font-manager
  noto-fonts
  noto-fonts-emoji
  ttf-droid  # Required for vscode
  ttf-fira-code  # For coding
  ttf-ibm-plex  # Just a nice looking font
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"

# Rebuild font cache
fc-cache -f -v