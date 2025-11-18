# VPN

Don't hassle with any gui or "official apps". This method is easy, fast to setup, and not hard to maintain.

## Table of contens

- [VPN](#vpn)
  - [Table of contens](#table-of-contens)
  - [Installation](#installation)
    - [1. The config file](#1-the-config-file)
      - [1.1 DNS overlap](#11-dns-overlap)
    - [2. Make sure you’re not running two network stacks](#2-make-sure-youre-not-running-two-network-stacks)
    - [3. Import the WG config into NM and autoconnect](#3-import-the-wg-config-into-nm-and-autoconnect)
  - [Turn off](#turn-off)
  - [Switch to another config](#switch-to-another-config)
    - [1. Import the other config (once)](#1-import-the-other-config-once)
    - [2. Make the switch](#2-make-the-switch)
  - [Rename / delete a connection (optional)](#rename--delete-a-connection-optional)

## Installation

### 1. The config file

Obtain or create the wireguard config file (`.config`), and place it into `/etc/wireguard`.

The file name should be a max of 18 characters, lowercase and no spaces (including `_` or `-`).

#### 1.1 DNS overlap

Make sure to remove (or comment out) the `DNS=` part from the config file, if you have a separate DNS running (like NextDNS).

### 2. Make sure you’re not running two network stacks

```bash
# If these exist/are enabled, turn them off (no error if absent)
sudo systemctl disable --now systemd-networkd systemd-networkd-wait-online 2>/dev/null
```

### 3. Import the WG config into NM and autoconnect

```bash
nmcli connection import type wireguard file /etc/wireguard/uk183.conf
# Grab the name NM assigned (likely 'uk183' or the filename)
nmcli -f NAME,TYPE connection show | grep wireguard

# Replace <NAME> with whatever you saw above
nmcli connection modify <NAME> connection.autoconnect yes connection.autoconnect-priority 10
nmcli connection up <NAME>
```

## Turn off

Just for this session:

```bash
nmcli connection show --active | grep wireguard
nmcli connection down <WG-NAME>
```

Keep it off across reboots:

```bash
nmcli connection modify <WG-NAME> connection.autoconnect no
nmcli connection down <WG-NAME>
```

## Switch to another config

### 1. Import the other config (once)

```bash
sudo nmcli connection import type wireguard file /etc/wireguard/<other>.conf
```

### 2. Make the switch

```bash
# Turn current one off and stop autoconnect
nmcli connection down <current>
nmcli connection modify <current> connection.autoconnect no

# Bring the new one up and enable autoconnect
nmcli connection up <other>
nmcli connection modify <other> connection.autoconnect yes connection.autoconnect-priority 10
```

> [!TIP] List them with
`nmcli -f NAME,TYPE,AUTOCONNECT connection show | grep wireguard`

## Rename / delete a connection (optional)

```bash
nmcli connection rename <old> <new>
nmcli connection delete <WG-NAME>
```
