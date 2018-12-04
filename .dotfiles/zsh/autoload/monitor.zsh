function _get_monitors() {
  xrandr -q | grep " connected" | cut -d ' ' -f1 | grep -v "eDP" | grep -v "LVDS"
}

export MONITOR1=$(_get_monitors | head -n 1)
export MONITOR2=$(_get_monitors | sed -n 2p)
