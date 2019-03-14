HOME=~
export EDITOR=vim
export VISUAL=$EDITOR
export TCLLIBPATH=$HOME/.dotfiles/tclsh
export NO_AT_BRIDGE=1
export LOGNAME=$(id -un)
export THIRDPARTY=$HOME/.thirdparty

# complete hostnames from this file
: ${HOSTFILE=$HOME/.ssh/known_hosts}
export HOSTFILE

# enable en_US locale w/ utf-8 encodings if not already configured
LANG="en_US.UTF-8"
: ${LANGUAGE:="en_US.UTF-8"}
: ${LC_CTYPE:="en_US.UTF-8"}
: ${LC_ALL:="en_US.UTF-8"}
export LANG LANGUAGE LC_CTYPE LC_ALL

foreach file in $(ls $HOME/.dotfiles/zsh/*); do
  . $file
done

PATH="/usr/local/sbin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="/usr/sbin:$PATH"
PATH="/usr/bin:$PATH"
PATH="/usr/games:$PATH"
PATH="/sbin:$PATH"
PATH="/bin:$PATH"
PATH="$HOME/.dotfiles/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
export PATH=$(clearpath.tcl)

FPATH="$HOME/.cache/zsh:$FPATH"

autoload -U promptinit; promptinit
prompt pure

source $THIRDPARTY/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
