#!/bin/bash

SERVICES=${SERVICES_BASE}/services
SELECTION=$(cat $SERVICES | rofi -dmenu)
[[ -z $SELECTION ]] && exit 0
MODE=$(echo -e "restart\nstart\nstop" | rofi -dmenu)
[[ -z $MODE ]] && exit 0
echo "sudo systemctl $MODE $SELECTION" | xclip -sel c -f | xclip -sel p

