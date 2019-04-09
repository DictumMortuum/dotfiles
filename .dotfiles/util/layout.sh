#!/bin/bash

MODE="1920x1080"
XRESOURCES_FILE=~/.cache/screenlayout/monitors
LAYOUT_FILE=~/.cache/screenlayout/layout

cp /dev/null $XRESOURCES_FILE

if [[ -f $LAYOUT_FILE && $# -eq 0 ]]; then
  MONITORS=$(cat $LAYOUT_FILE)
else
  MONITORS=$*
  echo "$MONITORS" > $LAYOUT_FILE
fi

#
# Creates an xrandr script with the current monitor layout.
# The script is saved to a file so that it can be used on each startup.
# Usage: cat "MON1 MON2 MON3" | xargs layout.sh
# Result: MON1 (primary) - MON2 - MON3 - ...
#

set -- $MONITORS

COMMAND="xrandr --output $1 --primary --mode $MODE"

while(($# - 1)); do
  COMMAND+=" --output $2 --mode $MODE --right-of $1"
  shift
done

#
# Creates an Xresources file with the current monitor layout.
# It will also merge it so that xrdb is updated.
# Usage: echo "monitor1 monitor2 monitor3" | xargs xmonitors.sh
#

set -- $MONITORS

for i in $(seq 0 $(($# - 1))); do
  echo "*monitor${i}: $1" >> $XRESOURCES_FILE
  shift
done

xrdb -merge $XRESOURCES_FILE
eval $COMMAND
