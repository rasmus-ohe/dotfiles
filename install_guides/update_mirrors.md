# Updating AUR mirrors

Using `reflector` (installed via `pacman` or `yay`) lets you regenerate a fresh, fast mirrorlist.

## 1. Run reflector

```bash
sudo reflector --verbose --country Finland --protocol https --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
```

Breakdown:

- `--country Finland`: filters to local mirrors (geographically near you).
- `--protocol https`: ensures secure connections.
- `--latest 5`: only fetch the 5 most recently synced mirrors.
- `--sort rate`: ranks them by throughput.
- `--save: overwrites` /etc/pacman.d/mirrorlist with the new list.

## 2. Refresh

After generation, run:

```bash
sudo pacman -Syyu
```

to refresh the package database and upgrade packages. The extra `y` forces a full sync, which is especially useful after updating mirrors.
