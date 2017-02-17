# ENVIRONMENT SETUP
source $HOME/.zsh/default.zsh
SCRIPTS=$HOME/.zsh/autoload
THEMES=$HOME/.zsh/custom/themes
PLUGINS=$HOME/.zsh/custom/plugins
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

[[ $HOSTNAME != apparatus ]] && echo "Skipping: $NOT_INCLUDED"

# Plugins
[[ $ZSH_VERSION == <5->* ]] && source $PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
BASE_16=$HOME/.dotfiles/base16-shell
[ -n "$PS1" ] && [ -s $BASE_16/profile_helper.sh ] && eval "$($BASE_16/profile_helper.sh)"

# condense PATH entries
PATH=$(path.tcl)
