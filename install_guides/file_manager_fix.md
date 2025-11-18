# GTK File Manager fix

This will fix the issue that some apps don't correctly show a file dialog. \
And fix bulk renaming with (within Nemo) with `bulky`. \
Running this with Nemo (file manager) has been tested and works.

## Step 1. Install required packages

```bash
sudo pacman -S xdg-desktop-portal-hyprland xdg-desktop-portal-gtk
```

## Step 2. portals.conf

Create or edit `portals.conf`

```bash
mkdir -p ~/.config/xdg-desktop-portal/
nvim ~/.config/xdg-desktop-portal/portals.conf
```

Add the following content

```ini
[preferred]
default=gtk
```

This tells the portal system to use the GTK portal (file chooser) instead of KDE or GNOME ones.

## Step 3. Restart portal service

```bash
systemctl --user restart xdg-desktop-portal xdg-desktop-portal-hyprland
```

This applies the config file.

## Step 4. Restart apps

Fully quit and relaunch apps that would require these features. \
Now try uploading a file again via a website (e.g., Gmail, Discord, etc.) — it should now open a GTK-style file picker.

## Step 5. Install bulky

\*This is included in the `install_scripts/install.sh` file

```bash
yay -Syu --noconfirm bulky
```

## Step 6. Setup bulky within Nemo

Open Nemo `Edit → Preferences → Behavior → Bulk Rename` and set the command to:

```bash
bulky %F
```

Now pressing F2 in Nemo will launch Bulky’s GUI.
