#!/bin/bash

packages=(
  awatcher-bundle-bin  # ActivityWatch
  aw-watcher-media-player-git  # Media player watcher
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"