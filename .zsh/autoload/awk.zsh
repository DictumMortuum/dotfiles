require awk && return 1

# update path
PATH="$DOT_HOME/.awk/bin/:$PATH"

# For common awk functions
export AWKPATH="$DOT_HOME/.awk/lib"

alias awk="awk -i common.awk"
