#!/bin/bash

NOW=$(date +%F)
HOST=$(hostname)
PROGRESS=/tmp/bar${NOW}
TODO=/tmp/todo${NOW}

source ${HOME}/Sync/Secret/machine/${HOST}.vars

export XDG_RUNTIME_DIR DBUS_SESSION_BUS_ADDRESS

function redis-get() {
  echo "${1}=`redis-cli get ${1}`"
}

function redis-set() {
  redis-cli set $1 $2
}

function redis-import() {
  ID=$(id -u)
  redis-set THIS $(basename $0)
  redis-set USER $(id -un)
  redis-set HOST $(hostname)
  redis-set ID $ID
  redis-set XDG_RUNTIME_DIR "/run/user/$ID"
  redis-set DBUS_SESSION_BUS_ADDRESS "unix:path=/run/user/$ID/bus"
}

function redis-export() {
  redis-get THIS
  redis-get USER
  redis-get HOST
  redis-get ID
  redis-get JIRA_URL
  redis-get XDG_RUNTIME_DIR
  redis-get DBUS_SESSION_BUS_ADDRESS
}

function cleanup() {
  if [[ -f $PROGRESS ]]; then
    echo "" > $PROGRESS
    trigger-blocklet 11
  fi
}

trap cleanup EXIT

function revert-dpms() {
  xset dpms 0 0 0
}

function trigger-blocklet() {
  pkill -SIGRTMIN+$1 i3blocks
}

function progress() {
  for i in {0..100000}; do
    printf '#%.0s' $(seq $(( $i % 15 )) ) > $PROGRESS
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

function get-monitors() {
  xrandr -q | grep " connected" | cut -d " " -f1
}

function get-xrandr-file() {
  echo "$HOME/.cache/screenlayout/xrandr.$1"
}

function get-xresources-file() {
  echo "$HOME/.cache/screenlayout/xresources.$1"
}

function generate-xrandr() {
  MODE="1920x1080"
  LAYOUT_FILE=$(get-xrandr-file $#)

  cp /dev/null $LAYOUT_FILE

  COMMAND="xrandr --output $1 --primary --mode $MODE"

  while(($# - 1)); do
    COMMAND+=" --output $2 --mode $MODE --right-of $1"
    shift
  done

  echo "#!/bin/bash" > $LAYOUT_FILE
  echo $COMMAND >> $LAYOUT_FILE
  chmod +x $LAYOUT_FILE
  eval $COMMAND
}

function generate-xresources() {
  XRESOURCES_FILE=$(get-xresources-file $#)
  cp /dev/null $XRESOURCES_FILE
  shift
  echo "*secondary: $1" >> $XRESOURCES_FILE
  xrdb -merge $XRESOURCES_FILE
}

function sync-repo() {
  GIT_DIR=$1
  GIT_BRANCH=${2:-master}
  git -C $GIT_DIR pull origin ${GIT_BRANCH}
  git -C $GIT_DIR add -A
  git -C $GIT_DIR commit -m "${USER}@${HOST}" && notify "${GIT_DIR}"
  git -C $GIT_DIR push origin ${GIT_BRANCH}
}

function layout() {
  LAYOUT=$(get-monitors | tr '\n' ' ' | xargs permutations | rofi-select)
  [[ -z $LAYOUT ]] && exit 0
  generate-xrandr $LAYOUT
  generate-xresources $LAYOUT
  i3-msg restart
}

function detect-layout() {
  MONITORS=$(get-monitors | wc -l)
  xrdb -merge $(get-xresources-file $MONITORS)
  $(get-xrandr-file $MONITORS)
}

# qutebrowser

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

function qute-jira() {
  local tmp=$(cat $QUTE_TEXT | get-jira | rofi-select)
  [[ -z $tmp ]] && exit 0
  echo "open -t ${JIRA_URL}/${tmp}" >> "$QUTE_FIFO"
}

function qute-url() {
  local tmp=$(cat "$QUTE_HTML" | detect-url)
  [[ -z $tmp ]] && exit 0
  echo "open -t $tmp" >> "$QUTE_FIFO"
}

function qute-clone() {
  local repository=$(cat "$QUTE_HTML" | detect-url "(ssh://)?(git://)?git@")
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
  fi

  tmux new-window -c $path
}

function qute-tokens() {
  local tmp=$(cat "$QUTE_TEXT" | get-tokens | rofi-select)
  [[ -z $tmp ]] && exit 0
  echo $tmp | tr -d '[:space:]' | to-clipboard
}

# st

function st-jira() {
  local tmp=$(get-jira | rofi-select)
  [[ -z $tmp ]] && exit 0
  x-www-browser ${JIRA_URL}/${tmp}
}

function st-screenedit() {
  tmpfile=$(mktemp /tmp/st-edit.XXXXXX)
  trap 'rm "$tmpfile"' 0 1 15
  cat > "$tmpfile"
  st -e "vim" "$tmpfile"
}

function st-url() {
  local tmp=$(detect-url)
  [[ -z $tmp ]] && exit 0
  x-www-browser $tmp
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

function st-copy() {
  local tmp=$(get-tokens | rofi-select)
  [[ -z $tmp ]] && exit 0
  local cmd=$(echo -e "\ntail -f \nvi \ncode " | rofi-select)
  [[ -z $cmd ]] && exit 0
  type-text "${cmd}${tmp}"
}

function st-lines() {
  local tmp=$(filter-whitespace | rofi-select)
  [[ -z $tmp ]] && exit 0
  type-text "$tmp"
}

# i3

function i3-lock() {
  TMPIMG=/tmp/screen.png
  scrot $TMPIMG
  convert $TMPIMG -scale 5% -scale 2000% $TMPIMG
  xkb-switch -s us
  trap revert-dpms SIGHUP SIGINT SIGTERM
  i3lock -n -u -e -i $TMPIMG
  rm $TMPIMG
}

function i3-poweroff() {
  systemctl poweroff -i
}

function i3-reboot() {
  systemctl reboot
}

function i3-logout() {
  dm-tool switch-to-greeter
}

function i3-exit() {
  i3-msg exit
}

# todo

function todo-add() {
  cat $TODO | rofi -dmenu -p "todo" >> $TODO
  trigger-blocklet 10
}

function todo-del() {
  sed -i '1d' $TODO
  trigger-blocklet 10
}

function todo-shift() {
  head -n 1 $TODO >> $TODO
  sed -i '1d' $TODO
  trigger-blocklet 10
}

$*
