#!/bin/bash

packages=(
  python
  uv  # Modern package manager
)

# Install packages
yay -S --noconfirm "${packages[@]}"