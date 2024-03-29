HISTFILE=~/.cache/zsh/history
HISTSIZE=10000
SAVEHIST=10000
FPATH="$HOME/.cache/zsh:$FPATH"
PATH="/usr/bin:/usr/local/bin:/usr/local/sbin:$HOME/go/bin:$HOME/.local/bin:$PATH"

typeset -aU path

export EDITOR=vim
export VISUAL=$EDITOR
export NO_AT_BRIDGE=1
export WORDCHARS=''
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export PATH

zmodload -i zsh/complist

unsetopt menu_complete
unsetopt flowcontrol
setopt auto_menu
setopt complete_in_word
setopt always_to_end
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

alias dot="git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME"
alias mkt='cd $(mktemp -d -p . "temp.$(date +%F).XXXXXXXXX")'
alias ls=' ls --color=tty'
alias history=' fc -il 1'

zstyle ':completion:*' verbose true
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' accept-exact-dirs true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh/completion
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select
zstyle ':completion:*' single-ignored show
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
autoload -U edit-command-line
autoload -U promptinit
autoload -U compinit

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N edit-command-line

bindkey -e
bindkey ' ' magic-space
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^?' backward-delete-char
bindkey '\C-x\C-e' edit-command-line
bindkey "${terminfo[kdch1]}" delete-char
bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line

if [[ $(find ~/.cache/zsh/zcompdump -mtime -1 | wc -l) > 0 ]]; then
  compinit -d ~/.cache/zsh/zcompdump
else
  compinit -d ~/.cache/zsh/zcompdump -C
fi

promptinit
prompt pure

[[ -d /opt/domus ]] && source /opt/domus/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
