#!/bin/bash

packages=(
  udisks2 # Backend DBus service
  udiskie # Lightweight auto-mounting daemon that uses udisks2
  ncdu    # Disk usage analyzer
  dosfstools  # FAT formatting
  exfatprogs  # ExFAT formatting
  gnome-disk-utility  # Disk Management Utility
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"