#!/usr/bin/env sh

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    INTERFACE=$(ls /sys/class/net | grep en | tail -n 1) MONITOR=$m polybar --reload bar &
  done
else
  polybar --reload bar &
fi

echo "Bars launched..."
