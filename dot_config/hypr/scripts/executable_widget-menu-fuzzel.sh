#!/usr/bin/env sh
NOW="$(date '+%a %d %b %Y %H:%M')"

sum=0 count=0 overall="Discharging"
for b in /sys/class/power_supply/BAT*; do
  [ -d "$b" ] || continue
  cap="$(cat "$b/capacity" 2>/dev/null)"
  st="$(cat "$b/status" 2>/dev/null)"
  [ -n "$cap" ] && sum=$((sum + cap)) && count=$((count + 1))
  case "$st" in
    Charging|Full) overall="$st" ;;
  esac
done
[ "$count" -gt 0 ] && pct=$((sum / count)) || pct="?"

printf "  %s\n🔋  %s%% (%s)\n" "$NOW" "$pct" "$overall" | fuzzel --dmenu --prompt " "

