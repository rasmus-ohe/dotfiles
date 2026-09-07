#!/bin/bash

packages=(
  git
  github-cli
  lazygit
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"