#!/bin/bash

packages=(
  rawtherapee # Image editor
  digikam # Photo manager
  photon-studio-bin # Photoshop copy
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"
