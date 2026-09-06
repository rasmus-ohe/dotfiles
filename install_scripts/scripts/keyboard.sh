#!/bin/bash

packages=(
  swaykbdd  # Keyborad language changer
  wev  # Display input events
  wtype  # Simulate keyboard input
  ydotool # Simulate keyboard and mouse input
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"

# Copy service file(s) to system dir
sudo cp ~/.config/hypr/services/ydotoold.service /etc/systemd/system/

# Enable services
sudo systemctl enable ydotoold.service