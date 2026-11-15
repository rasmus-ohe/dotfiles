#!/bin/sh
# Create a top-level Btrfs subvolume (sibling of @, @home, ...) and its mount point.
# Usage: mksubvol.sh <name> <target-mount> [--nocow]

set -eu

usage() { echo "Usage: ${0##*/} <name> <target-mount> [--nocow]" >&2; exit 1; }

[ "$(id -u)" -eq 0 ] || exec sudo "$0" "$@"

name=
target=
nocow=0
for arg in "$@"; do
    case $arg in
        --nocow|-C) nocow=1 ;;
        -*) usage ;;
        *)
            if   [ -z "$name" ];   then name=$arg
            elif [ -z "$target" ]; then target=$arg
            else usage; fi
            ;;
    esac
done
[ -n "$name" ] && [ -n "$target" ] || usage

case $name in
    */*|*[[:space:]]*) echo "name must not contain slashes or whitespace" >&2; exit 1 ;;
esac
case $name in @*) ;; *) name="@$name" ;; esac   # enforce the @ naming convention

case $target in
    /*) ;;
    *) echo "target mount must be an absolute path" >&2; exit 1 ;;
esac
case $target in
    *[[:space:]]*) echo "target mount must not contain whitespace" >&2; exit 1 ;;
esac

if findmnt -rn "$target" >/dev/null 2>&1; then
    echo "$target is already a mount point" >&2; exit 1
fi
if [ -d "$target" ] && [ -n "$(ls -A "$target")" ]; then
    echo "warning: $target is not empty; mounting over it will hide its contents" >&2
fi

[ "$(findmnt -no FSTYPE /)" = btrfs ] || { echo "/ is not btrfs" >&2; exit 1; }
uuid=$(findmnt -no UUID /)

tmp=$(mktemp -d)
trap 'umount "$tmp" 2>/dev/null || true; rmdir "$tmp" 2>/dev/null || true' EXIT

mount -o subvolid=5 "UUID=$uuid" "$tmp"

[ ! -e "$tmp/$name" ] || { echo "$name already exists" >&2; exit 1; }

btrfs subvolume create "$tmp/$name"
if [ "$nocow" -eq 1 ]; then
    chattr +C "$tmp/$name"   # must be set while empty; new files inherit it
    echo "NOCOW set on $name"
fi

mkdir -p "$target"

# Build the fstab line from the options on your / entry
opts=$(awk '$2=="/" && $3=="btrfs" {print $4; exit}' /etc/fstab | sed "s|subvol=[^,]*\$|subvol=/$name|")
printf '\nAdd to /etc/fstab:\n\n# /dev/%s\nUUID=%s\t%s\tbtrfs\t%s\t0 0\n' \
    "$(lsblk -no PKNAME,NAME "$(findmnt -no SOURCE / | sed 's/\[.*//')" | awk 'NR==1{print $2}')" \
    "$uuid" "$target" "${opts:-<options>,subvol=/$name}"
printf '\nThen:\n  sudo mount -a\n  systemctl daemon-reload\n  sudo chown %s: %s\n  findmnt %s\n' \
    "${SUDO_USER:-$USER}" "$target" "$target"
