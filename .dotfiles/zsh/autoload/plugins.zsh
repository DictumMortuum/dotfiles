[[ $ZSH_VERSION == <5->* ]] && source $PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

fpath=( "$PLUGINS" $fpath )

autoload -U promptinit; promptinit
prompt pure

