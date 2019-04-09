#!/bin/bash

LAYOUT=$(~/.dotfiles/util/monitors.tcl | rofi -dmenu -i -matching fuzzy -p "layout")
[[ -z $LAYOUT ]] && exit 0
echo "$LAYOUT" | xargs ~/.dotfiles/util/layout.sh
