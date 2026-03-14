#!/usr/bin/env bash

WG_DIR="/etc/wireguard"
WG_DIR_PERM="755"
WG_CONF_PERM="600"


notify() {
  notify-send "VPN Menu" "$1"
}

check_permissions() {
  local needs_fix=0
  local msg=""

  # Check directory
  local dir_perm
  dir_perm=$(stat -c "%a" "$WG_DIR" 2>/dev/null)
  if [[ "$dir_perm" != "$WG_DIR_PERM" ]]; then
    msg+="Directory ${WG_DIR} is ${dir_perm}, expected ${WG_DIR_PERM}\n"
    needs_fix=1
  fi

  # Check .conf files
  local bad_confs=()
  while IFS= read -r f; do
    local perm
    perm=$(stat -c "%a" "$f")
    if [[ "$perm" != "$WG_CONF_PERM" ]]; then
      bad_confs+=("$f (${perm})")
      needs_fix=1
    fi
  done < <(find "$WG_DIR" -maxdepth 1 -name '*.conf')

  if [[ ${#bad_confs[@]} -gt 0 ]]; then
    msg+="Configs not set to ${WG_CONF_PERM}:\n"
    for f in "${bad_confs[@]}"; do
      msg+="  ${f}\n"
    done
  fi

  if [[ $needs_fix -eq 0 ]]; then
    return
  fi

  # Prompt user to fix
  pkexec bash -c "
    chmod ${WG_DIR_PERM} '${WG_DIR}'
    find '${WG_DIR}' -maxdepth 1 -name '*.conf' -exec chmod ${WG_CONF_PERM} {} +
  "
  notify "Permissions fixed ✓"

}

check_permissions

# Read .conf files without privilege
mapfile -t confs < <(find "$WG_DIR" -maxdepth 1 -name '*.conf' -printf '%f\n' 2>/dev/null \
  | sed 's/\.conf$//' | sort)

if [[ ${#confs[@]} -eq 0 ]]; then
  notify "No WireGuard configs found in ${WG_DIR}"
  exit 1
fi

choice=$(printf '%s\n' "Turn Off" "${confs[@]}" | \
  fuzzel --dmenu --prompt="VPN > ") || exit 1

case "$choice" in
  "Turn Off")
    pkexec bash -c '
      iface=$(wg show interfaces)
      if [[ -n "$iface" ]]; then
        wg-quick down "$iface"
        echo "$iface"
      fi
    ' | read -r iface

    if [[ -n "$iface" ]]; then
      notify "${iface} turned off"
    else
      notify "No active WireGuard interface found."
    fi
    ;;
  *)
    pkexec wg-quick up "$choice"
    notify "${choice} enabled"
    ;;
esac
