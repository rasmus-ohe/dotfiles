#!/bin/sh

get_symbol() {
  percentage=$1

  capacity="${percentage%\%}"

  # Capacity symbol logic
  if [ "$capacity" -ge 80 ]; then
      symbol="󰁹"
  elif [ "$capacity" -ge 50 ]; then
      symbol="󰂂"
  elif [ "$capacity" -ge 20 ]; then
      symbol="󰁿"
  else
      symbol="󰁺"
  fi

  echo "$symbol"
}

# ---- CONFIG ----
BLACKLIST="
DisplayDevice
"
# -----------------

msg=""

# Enumerate devices
devices=$(upower -e)

for dev in $devices; do
    # Skip AC adapters
    case "$dev" in
        *line_power*)
            continue
            ;;
    esac

    info="$(upower -i "$dev" 2>/dev/null)"

    # Extract percentage
    percentage="$(printf "%s\n" "$info" | awk -F': ' '/percentage:/ {print $2}' | xargs)"
    [ -z "$percentage" ] && continue

    # Blacklist check (substring match)
    skip=false
    for b in $BLACKLIST; do
        echo "$dev" | grep -qi "$b" && skip=true && break
    done
    [ "$skip" = true ] && continue

    # Get model/name if available
    model=$(upower -i "$dev" 2>/dev/null | awk -F': ' '/model:/ {print $2}' | xargs)
    [ -z "$model" ] && model="$dev"

    status="$(printf "%s\n" "$info" | awk -F': ' '/state:/ {print $2}' | xargs)"
    if [ "$status" = "charging" ]; then
      symbol="󰂄"
    else
      symbol="$( get_symbol "$percentage" )"
    fi

    time_str="$(printf "%s\n" "$info" | awk -F': ' '/time to/ {print $0}' | xargs)"
    
    echo "Timeline: $time_str"

    msg="$msg$symbol $percentage - $model"

    if [ -n "$time_str" ]; then
      time_val="${time_str#*: }"
      case "$time_str" in
        *empty*)
          time_val="Empty in $time_val"
          ;;
        *)
          time_val="Full in $time_val"
          ;;
      esac

      msg="$msg [$time_val]"
    fi

    msg="$msg\n"    
done

# Send notification if there is any device
[ -n "$msg" ] && notify-send -t 5000 -h string:synchronous:battery-capacity  "Battery capacity" "$(echo -e "$msg")"
