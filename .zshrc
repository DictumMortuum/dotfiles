HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
FPATH="$HOME/.cache/zsh:$FPATH"
PATH="/usr/local/sbin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="/usr/sbin:$PATH"
PATH="/usr/bin:$PATH"
PATH="/usr/games:$PATH"
PATH="/sbin:$PATH"
PATH="/bin:$PATH"
PATH="$HOME/.dotfiles/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"

typeset -aU path

export EDITOR=vim
export VISUAL=$EDITOR
export NO_AT_BRIDGE=1
export LOGNAME=$(id -un)
export WORDCHARS=''
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export NOTES_DIRECTORY="$HOME/Notes/nt"
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

# https://news.ycombinator.com/item?id=11070797
alias dot="git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME"
alias notes="git --git-dir=$HOME/Notes/.git --work-tree=$HOME/Notes"
alias today='date +%F'
alias now='date +%FT%T'
alias unixtime='date +%s%3N'
alias tmp='mktemp -d -p . "temp.$(now).XXXXXXXXX"'
alias mkt='cd $(tmp)'
alias mp3-dl='noglob youtube-dl --extract-audio --audio-format mp3'
alias weather='curl -q http://wttr.in/Athens'
alias moon='curl -q http://wttr.in/Moon'
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
alias vi='vim'
alias tempfox='firefox --new-instance --profile $(mktemp -d)'
alias branch='echo ${LOGNAME}-$(unixtime)'
alias system-update='ANSIBLE_CONFIG=~/.dotfiles/ansible/ansible.cfg ansible-playbook ~/.dotfiles/ansible/full.yml'
alias curl_status='curl -K ~/.config/curl/status'
alias curl_times='curl -K ~/.config/curl/times'
alias ls=' ls --color=tty'
alias ll=' ls -lh'
alias history=' fc -il 1'

function unescape() {
  printf '%b\n' "$(<$1)"
}

zstyle ':completion:*' verbose true
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' accept-exact-dirs true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh_completion
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select
zstyle ':completion:*' single-ignored show
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

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

promptinit
prompt pure

source ~/.thirdparty/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
