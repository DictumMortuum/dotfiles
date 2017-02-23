# BASICS
HOME=~
: ${DOT_HOME:=$HOME}
SCRIPTS=$DOT_HOME/.zsh/autoload
THEMES=$DOT_HOME/.zsh/custom/themes
PLUGINS=$DOT_HOME/.zsh/custom/plugins
LOGNAME=$(id -un)
UNAME=$(uname)
HOSTNAME=$(hostname)
EDITOR=vim
VISUAL=$EDITOR
export HOME DOT_HOME LOGNAME UNAME EDITOR HOSTNAME VISUAL

# complete hostnames from this file
: ${HOSTFILE=$HOME/.ssh/known_hosts}
export HOSTFILE

# enable en_US locale w/ utf-8 encodings if not already configured
: ${LANG:="en_US.UTF-8"}
: ${LANGUAGE:="en"}
: ${LC_CTYPE:="en_US.UTF-8"}
: ${LC_ALL:="en_US.UTF-8"}
export LANG LANGUAGE LC_CTYPE LC_ALL

# modules
NOT_INCLUDED=()

require() {
  if type $1 > /dev/null 2>&1 ; then
    return 1
  else
    return 0
  fi
}

include() {
  if ! source $1; then
    NOT_INCLUDED+=($(basename $1))
  fi
}

foreach file in $(ls $SCRIPTS/* $THEMES/*); do
  include $file
done

[[ ${#NOT_INCLUDED[@]} -gt 0 ]] && echo "Skipping: $NOT_INCLUDED"

# PATH
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"
test -d "/snap/bin" && PATH="/snap/bin:$PATH"
test -d "/usr/games" && PATH="/usr/games:$PATH"
test -d "/usr/local/games" && PATH="/usr/local/games:$PATH"
test -d "$HOME/.dotfiles/bin" && PATH="$HOME/.dotfiles/bin:$PATH"

# condense PATH entries
export PATH=$(path.tcl)
