require alias && return 1

alias apt-update="sudo apt-get --yes update ; sudo apt-get --yes upgrade ; sudo apt-get --yes autoclean ; sudo apt-get --yes autoremove"

# https://news.ycombinator.com/item?id=11070797
# http://stackoverflow.com/questions/1030169/easy-way-pull-latest-of-all-submodules
alias dot="git --git-dir=$DOT_HOME/dotfiles.git --work-tree=$DOT_HOME"

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
