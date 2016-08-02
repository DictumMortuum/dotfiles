# update path
PATH="$HOME/.awk/bin/:$PATH"

# For common awk functions
export AWKPATH="$HOME/.awk/lib"

alias awk="awk -i common.awk"
