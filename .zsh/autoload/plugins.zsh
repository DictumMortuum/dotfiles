# Plugins
[[ $ZSH_VERSION == <5->* ]] && source $PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
#source $PLUGINS/zsh-async/async.plugin.zsh
#source $PLUGINS/pure/pure.plugin.zsh

fpath=( "$PLUGINS" $fpath )

autoload -U promptinit; promptinit
prompt pure

BASE16_SHELL=$DOT_HOME/.dotfiles/base16-shell
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
