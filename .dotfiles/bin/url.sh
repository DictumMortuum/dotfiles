#!/bin/bash

URL=$(xurls | rofi -dmenu)
[[ -z URL ]] && exit 0
x-www-browser $URL
