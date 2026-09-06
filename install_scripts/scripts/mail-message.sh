#!/bin/bash

packages=(
#   betterbird-bin  # Thunderbird alternative (mail client)
  tutanota-desktop-bin  # TutaNota mail
  beeper-v4-bin  # Beeper messanger

  neomutt   # TUI email client
  oama-bin  # OAuth manager
  isync     # Synchronize email files between devices
  goimapnotify  # IMAP email notifier
  msmtp  # SMTP client for sending emails
)

# Install packages
yay -S --noconfirm --needed "${packages[@]}"

# !!! goimapnotify services should be enabled manually after installation !!!