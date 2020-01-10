#!/bin/bash

ID=$(id -u)
export XDG_RUNTIME_DIR="/run/user/${ID}"
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/${ID}/bus"

function trigger-blocklet() {
  pkill -SIGRTMIN+$1 i3blocks
}

function progress() {
  date +%s%3N > /tmp/unix
  for i in {0..100000}; do
    trigger-blocklet 11
    sleep .1
  done
}

function http-status() {
  curl -s -o /dev/null -w "%{http_code}" $1
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
  i3-utils display active
}

function get-xrandr-file() {
  echo "$HOME/.cache/screenlayout/xrandr.$1"
}

function generate-xrandr() {
  LAYOUT_FILE=$(get-xrandr-file $#)

  cp /dev/null $LAYOUT_FILE

  echo "#!/bin/bash" >> $LAYOUT_FILE
  echo "xrandr --setprovideroutputsource modesetting NVIDIA-0" >> $LAYOUT_FILE
  echo "xrandr --output $1 --auto" >> $LAYOUT_FILE

  while(($# - 1)); do
    echo "xrandr --output $2 --auto --right-of $1" >> $LAYOUT_FILE
    shift
  done

  echo "xrandr --output $1 --primary" >> $LAYOUT_FILE

  chmod +x $LAYOUT_FILE
  $LAYOUT_FILE
}

function sync-repo() {
  GIT_DIR=$1
  GIT_BRANCH=${2:-master}
  git -C $GIT_DIR pull origin ${GIT_BRANCH}
  git -C $GIT_DIR add -A
  git -C $GIT_DIR commit -m "$(id -un)@$(hostname)" && notify-send $(basename $0) "${GIT_DIR}"
  git -C $GIT_DIR push origin ${GIT_BRANCH}
}

function layout() {
  LAYOUT=$(get-monitors | tr '\n' ' ' | xargs permutations | rofi-select)
  [[ -z $LAYOUT ]] && exit 0
  generate-xrandr $LAYOUT
  i3-msg restart
}

function detect-layout() {
  $(get-xrandr-file $(get-monitors | wc -l))
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
  echo "open -t https://jira.openbet.com/browse/${tmp}" >> "$QUTE_FIFO"
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
    notify-send $(basename $0) "$path finished cloning"
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
  xdg-open https://jira.openbet.com/browse/${tmp}
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
  xdg-open $tmp
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
  trap "xset dpms 0 0 0" SIGHUP SIGINT SIGTERM
  i3lock -n -u -e -i $TMPIMG
  rm $TMPIMG
}

$*
