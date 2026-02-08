#!/bin/bash

# Exit immediately if a command exits with a non-zero status
#set -e

# Install yay (Yet Another Yogurt - AUR helper)
if ! command -v yay &>/dev/null; then
  echo "Installing yay..."
  sudo pacman -S --needed git base-devel
  git clone https://aur.archlinux.org/yay.git
  cd yay || exit
  makepkg -si
  cd ..
  rm -rf yay
else
  echo "yay is already installed."
fi
  
# Update system
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Keyd service
sudo pacman -S --noconfirm keyd
echo "Copying keyd config file..."
sudo mkdir -p /etc/keyd
sudo cp ../etc/keyd/default.conf /etc/keyd/default.conf
sudo systemctl enable --now keyd

# Enable bluetooth
sudo pacman -S blueman bluez bluez-utils
sudo systemctl enable --now bluetooth


# Uninstall unwanted packages
sudo pacman -Rns vim --noconfirm

yay_packages=(
  linux-lts-headers
  
  # Network
  networkmanager  # Automatically connects to networks
  nm-connection-editor  # Network manager GUI
  network-manager-applet  # Applet for managing network connections
  iftop  # TUI network monitor
  ufw  # Netfilter firewall 
  wireguard-tools  # Tools for configuring Wireguard
  systemd-resolvconf  # Configure systemd-resolved
  speedtest++  # Network speed test

  # Git
  git
  github-cli
  lazygit

  # Notifications
  libnotify # Notifications (notify-send)
  swaync # Notification daemon

  # Language tools
  languagetool
  nuspell  # Used by libreoffice

  # Themes
  gtk3-demos
  gtk4-demos
  gnome-themes-extra

  # Fonts
  font-manager
  noto-fonts
  noto-fonts-emoji
  ttf-droid  # Required for vscode
  ttf-fira-code  # For coding

  # Files
  gvim  # vim + plugins
  neovim  # vim on steroids
  udisks2 # Backend DBus service
  udiskie  # Lightweight auto-mounting daemon that uses udisks2
  nemo  # File manager
  nemo-fileroller  # Compression settings
  nemo-terminal  # Terminal within nemo
  nemo-preview  # Quick preview files with `space`
  nemo-image-converter  # Rotate and resize images
  bulky  # Bulk renamer (for Nemo)
  zathura  # PDF/image viewer
  zathura-cb  # Comic books support
  zathura-pdf-mupdf  # EPUB, PDF and XPS support based on MuPDF
  yazi  # Terminal file manager
  unzip
  zip
  unrar
  7zip
  libreoffice-fresh  # Office suite
  voikko-libreoffice # Finnish spell checking for libreoffice
  syncthing  # File sharing
  syncthing-gtk  # GUI for Syncthing
  visual-studio-code-bin  # VSCode
  ncdu  # Disk usage analyzer
  trashy  # Trash manager; safer `rm` alternative
  fzf  # Fuzzy search
  lsd  # Modernized `ls`
  dosfstools  # FAT formatting
  exfatprogs  # ExFAT formatting
  gnome-disk-utility  # Disk Management Utility
  glow  # Markdown viewer in terminal

  # Media
  vlc  # Media player
  vlc-plugins-all  # Different codec support
  spotify-edge  # Spotify-client
  playerctl  # Aufio control with shortcuts
  mpv  # Media player
  audacity  # Audio editor
  kdenlive  # Video editor

  # Web browsers
  firefox  # Basic firefox
  zen-browser-bin  # Moddable firefox
  ddgr  # DuckDuckGo TUI
  min-browser-bin  # Minimalistic chromium-browser

  # Security
  bitwarden  # Password manager
  gnome-keyring ## Required by ente-auth-bin
  libsecret ## Required by ente-auth-bin
  seahorse # Keyring GUI
  ente-auth-bin  # 2FA manager

  # Social
  betterbird-bin  # Thunderbird alternative (mail client)
  tutanota-desktop-bin  # TutaNota mail
  beeper-v4-bin  # Beeper messanger
  vesktop-bin  # Alternative Discord client

  # Hyprland
  hyprshot  # Hyprland screenshot tool
  hyprshade  # Hyprland night light daemon
  hyprlock  # Session lock
  hyprpicker  # Color picker
  hypr-zoom  # Zoom-tool

  # Tools
  selectdefaultapplication-git  # See default applications
  corectrl  # CPU/GPU overclocking
  fastfetch  # System info
  btop  # System monitor
  swaykbdd  # Keyborad language changer
  kanshi  # Multi monitor profiles
  pavucontrol  # Volume control (pulseaudio)
  nwg-displays  # Display manager
  brightnessctl  # Brightness control
  mission-center  # GUI btop
  nwg-look  # GTK settings manager
  kicad  # Electronics design
  systemd-ui  # GUI for systemd units
  wtype  # Simulate keyboard input
  wev  # Display input events
  translate-shell  # CLI translator (using Google, Bing, Yandex, etc.)

  # Printing and scanning
  cups  # Pringing system
  cups-pdf  # "pring" into PDF
  simple-scanner  # Gnome GUI for scanning
  system-config-printer  # Printer setup GUI

  # Docker
  docker
  docker-compose

  # Clipboard
  wl-clipboard  # Wayland clipboard
  wl-clip-persist  # Clipboard persistence
  cliphist  # Clipboard history manager

  # Other
  flatseal  # Flatpak permissions manager
  hyprpolkitagent  # Popup for root password
  piper  # Logitech mouse daemon
  solaar  # Logitech device manager
  man  # Manual pages
  qbittorrent  # Torrent client
  pacman-contrib  #  Required for `checkupdates`
  xdg-desktop-portal-hyprland
  xdg-desktop-portal-gtk
  scrcpy  # Mirror Android device to desktop
  fuzzel  # Application launcher
  gnome-calculator  # Basic calcualtor with GUI
  qt5-wayland
  qt6-wayland
  battery-notify  # Battery status notifier
  reflector  # Arch mirrorlist updater
  tealdeer  # Modernized `man`
  battery-notify  # Battery notifier (inc. bluetooth devices)
  cpio  #
  activitywarch-bin  # Application time tracker
  fd  # Alternative to 'find' command (required for fzf.fish)
)

# Install packages (AUR)
echo "Installing packages (AUR)..."
yay -S --noconfirm --needed --quiet "${yay_packages[@]}"


# Make zathura the default PDF viewer
xdg-mime default org.pwmt.zathura.desktop application/pdf

# Make Nemo the default file manager
xdg-mime default nemo.desktop inode/directory

# Rebuild font cache
fc-cache -f -v

