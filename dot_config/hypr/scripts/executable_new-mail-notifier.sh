#!/bin/sh

# label:path pairs — add new accounts here only
accounts="
Gmail:$HOME/.mail/gmail/Inbox/new
Outlook Ohert:$HOME/.mail/outlook-ohert/Inbox/new
Outlook Michael:$HOME/.mail/outlook-michael/Inbox/new
"

body=""
total=0

old_ifs="$IFS"
IFS='
'
for entry in $accounts; do
  [ -z "$entry" ] && continue

  label="${entry%%:*}"
  path="${entry#*:}"

  [ -d "$path" ] || continue

  count=$(find "$path" -type f | wc -l)
  [ "$count" -eq 0 ] && continue

  total=$((total + count))
  if [ -z "$body" ]; then
    body="$label: $count"
  else
    body="$body
$label: $count"
  fi
done
IFS="$old_ifs"

[ "$total" -eq 0 ] && exit 0

notify-send -t 5000 -h string:synchronous:new-mail " New mail" "$body"
mpv --really-quiet --no-video ~/.config/hypr/audio/new-mail.ogg