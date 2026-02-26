#!/bin/sh

input_path="$1"

if [ ! -e "$input_path" ]; then
  echo "Given path does not exist"
  exit 0
fi

chezmoi forget $input_path
chezmoi add $input_path
