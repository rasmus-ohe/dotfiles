# Battery Management

## Installation

`yay -Syu --noconfirm tlpui tlp-rdw tlpui`

## Service

```bash
# Enable required services
systemctl enable tlp.service
systemctl enable NetworkManager-dispatcher.service

# Mask these services to avoid conflict
systemctl mask systemd-rfkill.service systemd-rfkill.socket
```

## Run

Test running it with `tlp start`
