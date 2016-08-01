# BASICS

: ${HOME=~}
: ${LOGNAME=$(id -un)}
: ${UNAME=$(uname)}

# complete hostnames from this file
: ${HOSTFILE=~/.ssh/known_hosts}

# enable en_US locale w/ utf-8 encodings if not already configured
: ${LANG:="en_US.UTF-8"}
: ${LANGUAGE:="en"}
: ${LC_CTYPE:="en_US.UTF-8"}
: ${LC_ALL:="en_US.UTF-8"}
export LANG LANGUAGE LC_CTYPE LC_ALL

# PATH

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
test -d "/snap/bin" && PATH="/snap/bin:$PATH"
test -d "/usr/games" && PATH="/usr/games:$PATH"
test -d "/usr/local/games" && PATH="/usr/local/games:$PATH"
test -d "$HOME/.dotfiles/bin" && PATH="$HOME/.dotfiles/bin:$PATH"

# ALIASES / FUNCTIONS

foreach file in $(ls $HOME/.zsh/autoload); do
  # http://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash
  comm="${file%.*}"
  # http://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script
  if type $comm >/dev/null 2>&1; then
    source $HOME/.zsh/autoload/$file
  fi
done

# USER SHELL ENVIRONMENT

# Usage: puniq [<path>]
# Remove duplicate entries from a PATH style value while retaining
# the original order. Use PATH if no <path> is given.
#
# Example:
#   $ puniq /usr/bin:/usr/local/bin:/usr/bin
#   /usr/bin:/usr/local/bin
puniq () {
    echo "$1" |tr : '\n' |nl |sort -u -k 2,2 |sort -n |
    cut -f 2- |tr '\n' : |sed -e 's/:$//' -e 's/^://'
}

# condense PATH entries
PATH=$(puniq $PATH)
export EDITOR='vim'
