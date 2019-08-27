#!/bin/bash

function type-text() {
  xdotool type --delay 3 --clearmodifiers -- "$*"
}

function filter-whitespace() {
  grep -v -e '^[[:space:]]*$'
}

function get-tokens() {
  grep -o -E '[^[:space:]]+' | sort -u -f -r
}

function rofi-select() {
  rofi -dmenu -matching fuzzy -i
}

function to-clipboard() {
  xclip -sel c -f | xclip -sel p
}

function screenedit() {
  tmpfile=$(mktemp /tmp/st-edit.XXXXXX)
  trap 'rm "$tmpfile"' 0 1 15
  cat > "$tmpfile"
  st -e "vim" "$tmpfile"
}

function url() {
  local tmp=$(xurls | rofi-select)
  x-www-browser $tmp
}

function lines() {
  local tmp=$(filter-whitespace | rofi-select)
  type-text "$tmp"
}

function tokens() {
  local tmp=$(get-tokens | rofi-select)
  local cmd=$(echo -e "\ntail -f \nvi \ncode " | rofi-select)
  type-text "${cmd}${tmp}"
}

function copy() {
  get-tokens | rofi-select | to-clipboard
}

function superuser() {
  local user=$(echo -e "openbet\ninformix\nobdba\ncentos\nroot" | rofi-select)
  type-text "sudo -iu ${user}"
}

$1
