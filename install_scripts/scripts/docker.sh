#!/bin/bash

packages=(
  docker  # Containerization platform
  docker-compose  # Tool for defining and running multi-container Docker applications
  lazydocker-bin  # TUI for managing Docker
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"

# Enable socket
sudo systemctl enable docker.socket

# Add user to docker group
sudo usermod -aG docker $USER