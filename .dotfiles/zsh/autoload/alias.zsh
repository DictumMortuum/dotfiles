# https://news.ycombinator.com/item?id=11070797
# http://stackoverflow.com/questions/1030169/easy-way-pull-latest-of-all-submodules
alias dot="git --git-dir=$HOME/dotfiles.git --work-tree=$HOME"
alias notes="git --git-dir=$HOME/Notes/.git --work-tree=$HOME/Notes"
alias awk="awk -i common.awk"
alias today="date +%F"
alias tmp='mktemp -d -p . "temp.$(today).XXXXXXXXX"'
alias mkt='cd $(tmp)'
alias mp3-dl="noglob youtube-dl --extract-audio --audio-format mp3"
alias http_code='curl --silent --show-error --output /dev/null --write-out "%{http_code}\n"'
alias weather="curl -q http://wttr.in/Athens"
alias moon="curl -q http://wttr.in/Moon"
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
alias vi='vim'
alias tempfox='firefox --new-instance --profile $(mktemp -d)'

# Assumes HIST_IGNORE_SPACE is set
# making aliases to certain commands to start with space to be ignored from history
alias ls=" ls --color=tty"
alias ll=" ls -lh"
alias history=" fc -il 1"

# rlwrap tclsh to get autocomplete and command history
# alias tclsh="rlwrap -z $HOME/.tclsh/autocomplete tclsh"
alias tclsh="rlwrap tclsh"

# Ubuntu custom shortcuts
# ctrl + alt + d
# sh -c 'xdotool type --clearmodifiers -- "$(date +%F)"'

alias times='curl --silent --show-error --output /dev/null --write-out "
time_namelookup: %{time_namelookup}
time_connect: %{time_connect}
time_appconnect: %{time_appconnect}
time_pretransfer: %{time_pretransfer}
time_redirect: %{time_redirect}
time_starttransfer: %{time_starttransfer}
time_total: %{time_total}"'

function unescape() {
  printf '%b\n' "$(<$1)"
}
