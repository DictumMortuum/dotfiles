require alias && return 1

# https://news.ycombinator.com/item?id=11070797
# http://stackoverflow.com/questions/1030169/easy-way-pull-latest-of-all-submodules
alias dot="git --git-dir=$HOME/dotfiles.git --work-tree=$HOME"
alias notes="git --git-dir=$HOME/notes/.git --work-tree=$HOME/notes"

# Assumes HIST_IGNORE_SPACE is set
# making aliases to certain commands to start with space to be ignored from history
alias ls=" ls --color=tty"
alias ll=" ls -lh"
alias history=" fc -il 1"

# Common typos
# Warning: highly personalized
alias ψδ=" cd"
alias λσ=" ls"
alias γιτ="git"

# 
alias today="date +%Y-%m-%d"

# Ubuntu custom shortcuts
# ctrl + alt + d
# sh -c 'xdotool type --clearmodifiers -- "$(date +%Y-%m-%d)"'
