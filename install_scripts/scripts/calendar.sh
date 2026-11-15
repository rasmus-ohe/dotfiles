#!/bin/bash

packages=(
  vdirsyncer  # Calendar sync
  khal   # Calendar/Schelude CLI tool
  khard  # Console address book manager

  chroncal-bin # TUI Calendar  
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"

# Rememebr to run `vdirsyncer sync` once to sync all collections

# Enable services
systemctl --user enable --now vdirsyncer.timer
chroncal service install
