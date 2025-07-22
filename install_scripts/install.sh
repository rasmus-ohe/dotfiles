#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

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


yay_packages=(
  linux-lts-headers
  
  # Network
  networkmanager  # Automatically connects to networks
  nm-connection-editor  # Network manager GUI

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

  # Files
  neovim  # File editor
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

  # Media
  vlc  # Media player
  vlc-plugins-all  # Different codec support
  spotify-edge  # Spotify-client
  playerctl  # Aufio control with shortcuts

  # Web browsers
  firefox  # Basic firefox
  zen-browser-bin  # Moddable firefox
  min  # Minimalistic web browser

  # Security
  bitwarden  # Password manager
  gnome-keyring ## Required by ente-auth-bin
  libsecret ## Required by ente-auth-bin
  ente-auth-bin  # 2FA manager

  # Social
  betterbird-bin  # Alternative to thunderbird (mail client)
  tutanota-desktop-bin  # TutaNota mail
  beeper-v4-bin  # Beeper messanger

  # Hyprland
  hyprshot  # Hyprland screenshot tool
  hyprshade  # Hyprland night light daemon
  hyprlock  # Session lock
  hyprpicker  # Color picker

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


  # Other
  flatseal  # Flatpak permissions manager
  hyprpolkitagent  # Popup for root password
  piper  # Logitech mouse daemon
  wl-clipboard  # Wayland clipboard
  man  # Manual pages
  qbittorrent  # Torrent client
  pacman-contrib  #  Required for `checkupdates`
  xdg-desktop-portal-hyprland
  xdg-desktop-portal-gtk
  scrcpy  # Mirror Android device to desktop
  fuzzel  # Application launcher
  gnome-calculator  # Basic calcualtor with GUI
)

# Install packages (AUR)
echo "Installing packages (AUR)..."
for package in "${yay_packages[@]}"; do
  yay -S --noconfirm "$package"
done

# Make zathura the default PDF viewer
xdg-mime default org.pwmt.zathura.desktop application/pdf

# Make Nemo the default file manager
xdg-mime default nemo.desktop inode/directory

# Enable the hypridle deamon
systemctl --user enable --now hypridle.service

