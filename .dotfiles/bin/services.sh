#!/bin/bash

SERVICES=${SERVICES_BASE}/services
SELECTION=$(cat $SERVICES | rofi -dmenu -multi-select)
[[ -z $SELECTION ]] && exit 0
MODE=$(echo -e "restart\nstart\nstop\nenable" | rofi -dmenu)
[[ -z $MODE ]] && exit 0
SERVICES=$(echo "$SELECTION" | tr '\n' ' ')
echo "sudo systemctl $MODE $SERVICES" | xclip -sel c -f | xclip -sel p

