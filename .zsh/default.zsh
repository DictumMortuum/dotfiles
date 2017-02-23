# BASICS

HOME=~
DOT_HOME=$HOME
LOGNAME=$(id -un)
UNAME=$(uname)
HOSTNAME=$(hostname)
EDITOR=vim
VISUAL=$EDITOR
export HOME LOGNAME UNAME EDITOR HOSTNAME VISUAL

# complete hostnames from this file
: ${HOSTFILE=$HOME/.ssh/known_hosts}
export HOSTFILE

# enable en_US locale w/ utf-8 encodings if not already configured
: ${LANG:="en_US.UTF-8"}
: ${LANGUAGE:="en"}
: ${LC_CTYPE:="en_US.UTF-8"}
: ${LC_ALL:="en_US.UTF-8"}
export LANG LANGUAGE LC_CTYPE LC_ALL

# PATH

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"
test -d "/snap/bin" && PATH="/snap/bin:$PATH"
test -d "/usr/games" && PATH="/usr/games:$PATH"
test -d "/usr/local/games" && PATH="/usr/local/games:$PATH"
test -d "$HOME/.dotfiles/bin" && PATH="$HOME/.dotfiles/bin:$PATH"
export PATH
