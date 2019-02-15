#!/bin/bash

platform=$(cat ~/.ssh/hosts | rofi -dmenu -matching fuzzy -only-match -location 0 -p "Box" )
query=$(ls ~/.ssh/env | grep -v config | rofi  -dmenu -matching fuzzy -location 0 -p "Env" )
i3-sensible-terminal -x ssh ${platform}.internal.${query}.sportsbook.sgdigital.com
exit 0

