HOME=~
export EDITOR=vim
export VISUAL=$EDITOR
export NO_AT_BRIDGE=1
export LOGNAME=$(id -un)

# complete hostnames from this file
: ${HOSTFILE=$HOME/.ssh/known_hosts}
export HOSTFILE

# enable en_US locale w/ utf-8 encodings if not already configured
LANG="en_US.UTF-8"
: ${LANGUAGE:="en_US.UTF-8"}
: ${LC_CTYPE:="en_US.UTF-8"}
: ${LC_ALL:="en_US.UTF-8"}
export LANG LANGUAGE LC_CTYPE LC_ALL

# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

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

source $HOME/.thirdparty/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
