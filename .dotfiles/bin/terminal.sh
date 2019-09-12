#!/bin/bash

WS=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name')
st -e tmux new-session -A -s W${WS} -D \; new-window -a

