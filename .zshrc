# ENVIRONMENT SETUP
source $HOME/.zsh/default.zsh

foreach file in $(ls $HOME/.zsh/*.zsh); do
  source $file
done

# Theme
source ~/.zsh/custom/themes/dictummortuum.zsh-theme

# Plugins
[[ $ZSH_VERSION == <5->* ]] && source ~/.zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
BASE16_SHELL=$HOME/.dotfiles/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# ALIASES / FUNCTIONS
foreach file in $(ls $HOME/.zsh/autoload); do
  # http://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash
  comm="${file%.*}"
  # http://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script
  type $comm >/dev/null 2>&1 && source $HOME/.zsh/autoload/$file
done

# http://www.zsh.org/mla/users/2002/msg00496.html
# http://zshwiki.org/home/cfg/zyrnix
# I don't know why this doesn't work in my cvs.zsh file.
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'

# condense PATH entries
PATH=$(path.tcl)
