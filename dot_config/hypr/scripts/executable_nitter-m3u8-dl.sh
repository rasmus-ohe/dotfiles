#!/bin/sh

set -eu

usage() {
    cat >&2 <<EOF
Usage:
  $(basename "$0") <nitter-m3u8-path> <output-filename>

Example:
  $(basename "$0") '/video/.../https%3A%2F%2Fvideo.twimg.com%2F...m3u8%3Ftag%3D14' my_video

Notes:
  - The input must be the Nitter-style encoded m3u8 path
  - Output will be written as MP4
  - ffmpeg and yt-dlp must be installed
EOF
    exit 1
}

[ $# -eq 2 ] || usage
[ "$1" = "-h" ] || [ "$1" = "--help" ] && usage

input="$1"
outfile="$2"

# Strip everything before the encoded https URL
encoded_url="${input#*/https%3A%2F%2F}"
encoded_url="https%3A%2F%2F$encoded_url"

# URL-decode (POSIX-safe)
decoded_url=$(printf '%b' "$(echo "$encoded_url" | sed 's/%/\\x/g')")

# Ensure .mp4 extension
case "$outfile" in
    *.mp4) ;;
    *) outfile="$outfile.mp4" ;;
esac

exec yt-dlp \
    -f "bv*+ba/b" \
    --merge-output-format mp4 \
    -o "$outfile" \
    "$decoded_url"
