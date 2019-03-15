# https://news.ycombinator.com/item?id=11070797
# http://stackoverflow.com/questions/1030169/easy-way-pull-latest-of-all-submodules
alias dot="git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME"
alias notes="git --git-dir=$HOME/Notes/.git --work-tree=$HOME/Notes"
alias awk="awk -i common.awk"
alias today="date +%F"
alias tmp='mktemp -d -p . "temp.$(today).XXXXXXXXX"'
alias mkt='cd $(tmp)'
alias mp3-dl="noglob youtube-dl --extract-audio --audio-format mp3"
alias weather="curl -q http://wttr.in/Athens"
alias moon="curl -q http://wttr.in/Moon"
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
alias vi='vim'
alias tempfox='firefox --new-instance --profile $(mktemp -d)'
alias unixtime='date +%s%3N'
alias branch='echo ${LOGNAME}-$(unixtime)'
alias system-update='ANSIBLE_CONFIG=~/.dotfiles/ansible/ansible.cfg ansible-playbook ~/.dotfiles/ansible/update.yml --skip-tags "install"'
alias system-update-full='ANSIBLE_CONFIG=~/.dotfiles/ansible/ansible.cfg ansible-playbook ~/.dotfiles/ansible/full.yml'
alias tclsh="rlwrap tclsh"
alias curl='curl -K ~/.config/curl/config'
alias curl_status='curl -K ~/.config/curl/status'
alias curl_times='curl -K ~/.config/curl/times'

# Assumes HIST_IGNORE_SPACE is set
# making aliases to certain commands to start with space to be ignored from history
alias ls=" ls --color=tty"
alias ll=" ls -lh"
alias history=" fc -il 1"

function unescape() {
  printf '%b\n' "$(<$1)"
}
