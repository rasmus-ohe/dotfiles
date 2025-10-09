#!/bin/sh

usage() {
  echo "Usage: lnsh [-d dir]... <script_name>"
  exit 1
}

dir_path=""
script_name=""
positional_seen=0

while [ "$1" ]; do
  case "$1" in
    -d)
      shift
      [ -z "$1" ] && usage
      seg="$(echo "$1" | sed 's#^/*##; s#/*$##')"      # trim leading/trailing slashes
      [ -z "$seg" ] || dir_path="${dir_path:+$dir_path/}$seg"
      ;;
    --) shift; break ;;
    -*) usage ;;
    *)
      if [ "$positional_seen" -eq 1 ]; then usage; fi
      script_name="$1"
      positional_seen=1
      ;;
  esac
  shift
done

# Allow script name after `--`
if [ -z "$script_name" ] && [ -n "$1" ]; then
  script_name="$1"
fi

[ -z "$script_name" ] && usage

# Normalize any accidental duplicate slashes
dir_path="$(echo "$dir_path" | sed 's#//*#/#g; s#^/*##; s#/*$##')"

if [ -n "$dir_path" ]; then
  src="$HOME/.config/hypr/scripts/$dir_path/$script_name.sh"
else
  src="$HOME/.config/hypr/scripts/$script_name.sh"
fi

dest="$HOME/.local/bin/$script_name"


if [ ! -f "$src" ]; then
  echo "File not found: \"$src\""
  exit 1
fi

chmod +x "$src"
ln -sf "$src" "$dest"
echo "Linked $src -> $dest"
