#!/bin/bash

TODO=/tmp/$(date +%F)
touch $TODO

case $1 in
  add) cat $TODO | rofi -dmenu -p "todo" >> $TODO ;;
  del) sed -i '1d' $TODO ;;
  *) ;;
esac

pkill -SIGRTMIN+10 i3blocks
