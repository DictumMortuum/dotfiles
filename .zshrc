HOME=~
export PLUGINS=$HOME/.dotfiles/zsh/custom/plugins
export EDITOR=vim
export VISUAL=$EDITOR
export AWKPATH=$HOME/.dotfiles/awk
export TCLLIBPATH=$HOME/.dotfiles/tclsh

# complete hostnames from this file
: ${HOSTFILE=$HOME/.ssh/known_hosts}
export HOSTFILE

# enable en_US locale w/ utf-8 encodings if not already configured
: ${LANG:="en_US.UTF-8"}
: ${LANGUAGE:="en"}
: ${LC_CTYPE:="en_US.UTF-8"}
: ${LC_ALL:="en_US.UTF-8"}
export LANG LANGUAGE LC_CTYPE LC_ALL

foreach file in $(ls $HOME/.dotfiles/zsh/autoload/* ); do
  . $file
done

# PATH
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/.dotfiles/bin:$PATH"
test -d "/usr/games" && PATH="/usr/games:$PATH"

# condense PATH entries
export PATH=$(clearpath)
