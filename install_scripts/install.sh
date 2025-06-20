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


pacman_packages=(
  linux-lts-headers
  firefox
  neovim
  code  # Visual Studio Code
  fastfetch
  hyprpicker  # Colot picker
  bitwarden
  piper  # Logitech mouse daemon
  wl-clipboard  # Wayland clipboard
  man  # Manual pages
  btop  # System monitor
  qbittorrent  # Torrent client
  pacman-contrib  #  Required for `checkupdates`
  xdg-desktop-portal-hyprland
  xdg-desktop-portal-gtk
  kanshi  # Multi monitor profiles
  pavucontrol  # Volume control (pulseaudio)
  scrcpy  # Mirror Android device to desktop
  fuzzel  # Application launcher
  nwg-displays  # Display manager
  gnome-calculator  # Basic calcualtor with GUI
  brightnessctl

  # Network
  networkmanager  # Automatically connects to networks
  nm-connection-editor  # Network manager GUI
  
  # Required by ente-auth-bin
  gnome-keyring
  libsecret

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
  udisks2 # Backend DBus service
  udiskie  # Lightweight auto-mounting daemon that uses udisks2
  nemo  # File manager
  nemo-fileroller  # Compression settings
  nemo-terminal  # Terminal within nemo
  nemo-preview  # Quick preview files with `space`
  nemo-image-converter  # Rotate and resize images
  zathura  # PDF/image viewer
  zathura-cb  # Comic books support
  zathura-pdf-mupdf  # EPUB, PDF and XPS support based on MuPDF
  yazi  # Terminal file manager
  unzip
  zip
  unrar
  7zip
  libreoffice-fresh
  libreoffice-fresh-en-gb
  syncthing  # File sharing

  # Media
  vlc  # Media player
  spotify-edge  # Spotify-client
  playerctl  # Aufio control with shortcuts
)


yay_packages=(
  # Web browsers
  zen-browser-bin  # Moddable firefox
  min  # Minimalistic web browser

  # Other
  ente-auth-bin  # Ente auth daemon
  flatseal  # Flatpak permissions manager
  hyprshot  # Hyprland screenshot tool
  hyprshade  # Hyprland night light daemon
  selectdefaultapplication-git  # See default applications
  betterbird-bin  # Email client
  voikko-libreoffice # Finnish spell checking for libreoffice
  beeper-v4-bin  # Beeper messanger
  syncthing-gtk  # GUI for Syncthing
  tutanota-desktop-bin  # TutaNota mail
  bulky  # Bulk renamer (for Nemo)
  visual-studio-code-bin  # VSCode
)

# Install packages (pacman)
echo "Installing packages (pacman)..."
for package in "${pacman_packages[@]}"; do
  sudo pacman -S --noconfirm --needed "$package"
done

# Install packages (AUR)
echo "Installing packages (AUR)..."
for package in "${yay_packages[@]}"; do
  yay -S --noconfirm "$package"
done

# Make zathura the default PDF viewer
xdg-mime default org.pwmt.zathura.desktop application/pdf






