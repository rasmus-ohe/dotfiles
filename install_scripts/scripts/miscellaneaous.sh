#!/bin/bash

packages=(
  linux-lts-headers # Kernel headers

  fuzzel  # Application launcher
  
  selectdefaultapplication-git  # See default applications
  
  kicad   # Electronics design
  qbittorrent       # Torrent client
  gnome-calculator  # Basic calcualtor with GUI
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"