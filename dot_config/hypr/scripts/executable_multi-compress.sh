#!/bin/sh

for d in */; do
    7z a -t7z -mx=9 "${d%/}.7z" "$d"
done
