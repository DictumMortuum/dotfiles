#!/bin/bash

box=$(cat ~/.ssh/hosts | rofi -dmenu -matching fuzzy -location 0 -p "Box")
[[ -z $box ]] && exit 0
env=$(ls ~/.ssh/env | grep -v config | rofi -dmenu -matching fuzzy -location 0 -p "Env")
i3-sensible-terminal -x ssh ${box}.internal.${env}.sportsbook.sgdigital.com
exit 0
