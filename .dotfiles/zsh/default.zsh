# BASICS
HOME=~
: ${DOT_HOME:=$HOME}
SCRIPTS=$DOT_HOME/zsh/autoload
THEMES=$DOT_HOME/zsh/custom/themes
PLUGINS=$DOT_HOME/zsh/custom/plugins
LOGNAME=$(id -un)
UNAME=$(uname)
HOSTNAME=$(hostname)
SYSTEM=$(lsb_release -is)
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

foreach file in $(ls $SCRIPTS/* ); do
  . $file
done

# For common awk functions
export AWKPATH="$DOT_HOME/awk"

# This path will be added to auto_path tcl global.
# It will check that folder and its subfolders for pkgIndex.tcl files to source.
# If a package is required.
export TCLLIBPATH="$DOT_HOME/tclsh"

# PATH
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/.dotfiles/bin:$PATH"
test -d "/usr/games" && PATH="/usr/games:$PATH"

# condense PATH entries
export PATH=$(clearpath)
