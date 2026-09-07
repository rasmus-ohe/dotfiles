#!/bin/bash

packages=(
  piper  # Logitech mouse daemon
  solaar  # Logitech device manager
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"