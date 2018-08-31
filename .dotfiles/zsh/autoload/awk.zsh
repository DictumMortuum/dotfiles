require awk && return 1

# For common awk functions
export AWKPATH="$DOT_HOME/awk"

alias awk="awk -i common.awk"
