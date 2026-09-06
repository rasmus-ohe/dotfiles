#!/bin/bash

packages=(
  curl # HTTP client
  networkmanager  # Automatically connects to networks
  nm-connection-editor  # Network manager GUI
  network-manager-applet  # Applet for managing network connections
  iftop  # TUI network monitor
  ufw  # Netfilter firewall 
  wireguard-tools  # Tools for configuring Wireguard
  systemd-resolvconf  # Configure systemd-resolved
  speedtest++  # Network speed test
)


# Install packages (AUR)
yay -S --noconfirm --needed "${packages[@]}"

# Enable services
sudo systemctl enable --now NetworkManager
sudo systemctl enable --now ufw

sudo ufw enable