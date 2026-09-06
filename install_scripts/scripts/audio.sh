#!/bin/bash

packages=(
  vlc  # Media player
  vlc-plugins-all  # Different codec support

  spotify-edge  # Spotify-client

  playerctl  # Aufio control with shortcuts
  playerctld-systemd-unit  # Daemon for playerctl

  audacity  # Audio editor
  
  mpv  # Media player
  mpd  # Music Player Deamon
  mpc  # CLI for mpd
  mpd-mpris  # Playerctl control for mpd
  rmpc  # Rusty Music Player Clinent
  cava  # Audio visualizer

  pavucontrol  # Volume control (pulseaudio)
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"

# Enable services
systemctl --user enable --now playerctld.service
systemctl --user enable --now mpd.service