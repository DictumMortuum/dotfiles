#!/bin/bash

TMPBG=/tmp/screen.png

revert() {
  xset dpms 0 0 0
}

scrot $TMPBG && convert $TMPBG -scale 5% -scale 2000% $TMPBG

xkb-switch -s us
trap revert SIGHUP SIGINT SIGTERM

i3lock -u -e -i $TMPBG

rm $TMPBG
