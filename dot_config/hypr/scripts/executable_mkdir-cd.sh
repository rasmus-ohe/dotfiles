#!/bin/sh

DIR_PATH=$1

if [ -d "$DIR_PATH" ]; then
    cd "$DIR_PATH"
else
    mkdir -p "$DIR_PATH"
    cd "$DIR_PATH"
fi


