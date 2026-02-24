# Ydotool

Simulates key- and mouse-events

## Link

Github: https://github.com/ReimuNotMoe/ydotool

## Setup

### 1. Install

`yay -Syu --noconfirm --needed ydotool`

### 2. Link service

`sudo ln -s ~/.config/hypr/services/ydotoold.service /etc/systemd/system/`

### 3. Start service

`sudo systemctl enable --now ydotoold.service`

### 4. Test

`ydotol click`

## Full script

```shell
yay -Syu --noconfirm --needed ydotool
sudo ln -s ~/.config/hypr/services/ydotoold.service /etc/systemd/system/
sudo systemctl enable --now ydotoold.service
```
