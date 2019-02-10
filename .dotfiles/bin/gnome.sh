#!/bin/bash

# dconf dump /
# https://askubuntu.com/questions/451945/permanently-set-keyboard-layout-options-with-setxkbmap-in-gnome-unity
# https://askubuntu.com/questions/522833/how-to-dump-all-dconf-gsettings-so-that-i-can-compare-them-between-two-different

gsettings set org.gnome.settings-daemon.plugins.keyboard active false
