#!/bin/bash

packages=(
  unzip
  zip
  unrar
  7zip
  trashy  # Trash manager; safer `rm` alternative
  fzf   # Fuzzy search
  lsd   # Modernized `ls`
  fd    # Alternative to 'find' command (required for fzf.fish)
  cpio  # Copy files in and out of archives
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"