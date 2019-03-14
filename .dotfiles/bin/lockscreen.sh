#!/bin/bash

revert() {
  xset dpms 0 0 0
}

xkb-switch -s us
fscrn=$(mktemp --tmpdir XXXX.png)
scrot $fscrn
mogrify -scale 10% -scale 1000% $fscrn
trap revert SIGHUP SIGINT SIGTERM
i3lock -nui $fscrn
rm $fscrn
