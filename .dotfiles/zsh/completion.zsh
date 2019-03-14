zmodload -i zsh/complist

unsetopt menu_complete
unsetopt flowcontrol
setopt auto_menu
setopt complete_in_word
setopt always_to_end
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

bindkey -M menuselect '^o' accept-and-infer-next-history

zstyle ':completion:*' verbose true
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' accept-exact-dirs true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh_completion
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select
zstyle ':completion:*' single-ignored show
