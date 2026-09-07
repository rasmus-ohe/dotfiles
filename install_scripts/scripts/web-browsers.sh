#!/bin/bash

packages=(
  firefox  # Basic Firefox
  zen-browser-bin  # Modded Firefox
  ddgr  # DuckDuckGo TUI
  min-browser-bin  # Minimalistic chromium-browser
  google-chrome  # Google Chrome
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"