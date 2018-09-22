# https://news.ycombinator.com/item?id=11070797
# http://stackoverflow.com/questions/1030169/easy-way-pull-latest-of-all-submodules
alias dot="git --git-dir=$HOME/dotfiles.git --work-tree=$HOME"
alias notes="git --git-dir=$HOME/Notes/.git --work-tree=$HOME/Notes"
alias awk="awk -i common.awk"

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

# time & date
alias today="date +%Y-%m-%d"

# Ubuntu custom shortcuts
# ctrl + alt + d
# sh -c 'xdotool type --clearmodifiers -- "$(date +%Y-%m-%d)"'

# Using checklist: https://github.com/marinintim/checklist
alias cl="checklist -f ~/Notes/checklist/checklist.txt"
# daily list
alias dl="checklist -f ~/Notes/checklist/checklist.$(today).txt"

# Based on youtube-dl
alias mp3-dl="noglob youtube-dl --extract-audio --audio-format mp3"

# Openbet pipeline
alias pipeline=~/Code/us-entry-current-branches/pipeline

# rlwrap tclsh to get autocomplete and command history
# alias tclsh="rlwrap -z $HOME/.tclsh/autocomplete tclsh"
alias tclsh="rlwrap tclsh"

# http methods                    curl -XTRACE  <url>
# x-forwarded-for                 curl -H "X-Forwarded-For: 10.0.0.1" <url>
# basic authentication            curl -u <user>:<password> <url>
# post form                       curl -XPOST --form "b=4_1" <url>
# cookie                          curl --cookie "PHPSESSID=5ved46gn34dopkjhstrrfgdkk1;" <url>
# cookie files (save & send)      curl -c /tmp/cookie.txt -b /tmp/cookie.txt <url>
# set user-agent                  curl -A "Mozilla" <url>
# referer                         curl -H "Referer: https://www.cnn.com" <url>
# json                            curl -XPOST -H "Content-Type: application/json" -d "[[\"create\",
#                                 {\"type\":\"trial\",\"name\":\"bug\"}]] <url>
# silent                          curl -s <url>
# verbose                         curl -v <url>
# ignore certifikate issues       curl -k <url>
# follow redircts                 curl -L <url>
# redirect output into file       curl -o <file> <url>
# curl with proxy                 curl -x <proxy>:<port> <url>
# curl SSL V3                     curl -k -v --sslv3 <url>
# curl max time (4 seconds)       curl -m4 <url>
# file upload                     curl -XPOST -F ul=30000 -F location=/tmp/upload-form-data.txt
#                                 -F userfile=@/tmp/upload-file.txt <url>
# shell-shock                     curl -k -L -H 'User-Agent: () { :;}; curl -L  <return-server>;'  <url>
# post data from file             curl -data '@<filename>' <url>
# curl output response time       curl -o /dev/null -w%{time_connect}:%{time_starttransfer}%{time_total} <url>
# curl output request size        curl -o /dev/null -w%{size_request} %{size_upload} <url>
# curl output http status code    curl -o /dev/null -w%%{http_code} <url>
# curl resolve ip from other dns  curl --resolve "www.cnn.com:80:8.8.8.8" http://www.cnn.com

alias curltime="curl -K $DOT_HOME/curl/time.curl"
alias curlcode="curl -K $DOT_HOME/curl/code.curl"
alias @weather="curl -q http://wttr.in/Athens"
alias @moon="curl -q http://wttr.in/Moon"
