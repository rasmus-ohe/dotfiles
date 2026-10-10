#!/bin/bash

packages=(
  rawtherapee # Image editor
  digikam # Photo manager
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"
