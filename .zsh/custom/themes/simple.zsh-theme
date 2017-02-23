[[ $ZSH_VERSION != 4.* ]] && return 1
autoload -U colors && colors
DICTUM_USER="%B%{$fg[8]%}%n%f%b"
DICTUM_HOST="%B%{$fg[magenta]%}%m%f%b"
DICTUM_PROMPT="%B%{$fg[blue]%}%~%f%b"
PROMPT="$DICTUM_USER on $DICTUM_HOST in $DICTUM_PROMPT "
