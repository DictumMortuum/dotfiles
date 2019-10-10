#!/bin/bash

THIS=$(basename $0)
ID=$(id -u)
export XDG_RUNTIME_DIR=/run/user/$ID
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$ID/bus
JIRA_URL=${JIRA_URL:-"https://jira.openbet.com/browse"}

function cleanup() {
  PROGRESS=/tmp/bar$(date +%F)

  if [[ -f $PROGRESS ]]; then
    echo "" > $PROGRESS
    trigger-blocklet 11
  fi
}

trap cleanup EXIT

function trigger-blocklet() {
  pkill -SIGRTMIN+$1 i3blocks
}

function progress() {
  for i in {0..100000}; do
    printf '#%.0s' $(seq $(( $i % 15 )) ) > /tmp/bar$(date +%F)
    trigger-blocklet 11
    sleep .1
  done
}

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

function get-jira() {
  grep -o -E '[A-Z]+-[0-9]+' | sort -u
}

function get-tokens() {
  grep -o -E '[^[:space:]]+' | sort -u -f -r
}

function rofi-select() {
  rofi -dmenu -matching fuzzy -i
}

function get-clipboard() {
  xclip -o -sel clipboard
}

function to-clipboard() {
  xclip -sel clipboard
}

function get-primary() {
  xclip -o -sel primary
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

function qute-textedit() {
  st -e "vim" "$QUTE_TEXT"
}

function qute-copy() {
  cat $QUTE_TEXT | to-clipboard
}

function qute-select-copy() {
  echo $QUTE_SELECTED_TEXT | to-clipboard
}

function st-jira() {
  local tmp=$(get-jira | rofi-select)
  [[ -z $tmp ]] && exit 0
  x-www-browser ${JIRA_URL}/${tmp}
}

function qute-jira() {
  local tmp=$(cat $QUTE_TEXT | get-jira | rofi-select)
  [[ -z $tmp ]] && exit 0
  echo "open -t ${JIRA_URL}/${tmp}" >> "$QUTE_FIFO"
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
    progress &
    PID=$!
    git clone $repository $path
    kill $PID
    notify "$path finished cloning"
  else
    tmux new-window -c $path
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
  echo $tmp | tr -d '[:space:]' | to-clipboard
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
