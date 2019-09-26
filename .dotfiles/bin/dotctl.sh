#!/bin/bash

THIS=$(basename $0)
ID=$(id -u)
export XDG_RUNTIME_DIR=/run/user/$ID
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$ID/bus

function notify() {
  notify-send "${THIS}" "${1}"
}

function is-git-repo() {
  if [[ -d ${1}/.git ]] || git -C ${1} rev-parse --git-dir > /dev/null 2>&1; then
    return 0
  else
    return 1
  fi
}

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

function detect-url() {
  if [[ $# -eq 0 ]]; then
    xurls
  else
    xurls -m $1
  fi | sort | uniq | rofi-select
}

function st-screenedit() {
  tmpfile=$(mktemp /tmp/st-edit.XXXXXX)
  trap 'rm "$tmpfile"' 0 1 15
  cat > "$tmpfile"
  st -e "vim" "$tmpfile"
}

function qute-screenedit() {
  st -e "vim" "$QUTE_HTML"
}

function st-url() {
  local tmp=$(detect-url)
  [[ -z $tmp ]] && exit 0
  x-www-browser $tmp
}

function qute-url() {
  local tmp=$(cat "$QUTE_HTML" | detect-url)
  [[ -z $tmp ]] && exit 0
  echo "open -t $tmp" >> "$QUTE_FIFO"
}

function qute-clone() {
  local repository=$(cat "$QUTE_HTML" | detect-url "(git://)?git@")
  [[ -z $repository ]] && exit 0
  local tmp1=${repository##*:}
  local tmp2=${tmp1#[0-9]*/}
  local path="$HOME/Code/${tmp2%%.git}"
  mkdir -p $path

  if ! is-git-repo $path; then
    git clone $repository $path
    notify "$path finished cloning"
  else
    notify "$path already exists"
  fi

  echo $path | to-clipboard
}

function st-lines() {
  local tmp=$(filter-whitespace | rofi-select)
  [[ -z $tmp ]] && exit 0
  type-text "$tmp"
}

function st-copy() {
  local tmp=$(get-tokens | rofi-select)
  [[ -z $tmp ]] && exit 0
  local cmd=$(echo -e "\ntail -f \nvi \ncode " | rofi-select)
  [[ -z $cmd ]] && exit 0
  type-text "${cmd}${tmp}"
}

function qute-tokens() {
  local tmp=$(cat "$QUTE_TEXT" | get-tokens | rofi-select)
  [[ -z $tmp ]] && exit 0
  echo $tmp | to-clipboard
}

function st-tokens() {
  local tmp=$(get-tokens | rofi-select)
  [[ -z $tmp ]] && exit 0
  echo $tmp | to-clipboard
}

function st-superuser() {
  local user=$(echo -e "openbet\ninformix\nobdba\ncentos\nroot" | rofi-select)
  [[ -z $user ]] && exit 0
  type-text "sudo -iu ${user}"
}

$1
