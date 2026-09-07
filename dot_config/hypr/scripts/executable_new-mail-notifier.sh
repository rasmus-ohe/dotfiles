#!/bin/sh

# TODO: Fetch more than just one inbox
new_inbox_dir_path=~/.mail/gmail/Inbox/new

# Get amount of files in directory
new_mail_count=$(find "$new_inbox_dir_path" -type f | wc -l)

# Exit if no new mail
[ "$new_mail_count" -eq 0 ] && exit 0

# Notify
notify-send -t 5000 -h string:synchronous:new-mail " New mail" "Gmail: $new_mail_count"
mpv --really-quiet --no-video ~/.config/hypr/audio/new-mail.ogg