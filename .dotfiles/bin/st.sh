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
  local cmd=$(echo -e "\ntail -f \nvi \ncode \n" | rofi-select)
  type-text "${cmd}${tmp}"
}

$1
