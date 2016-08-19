# Make directory and change into it.
function @mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Create a directory like "year-month-day" (i.e. 2008-08-31)
function @mkd() {
  mkdir $(date +%F) && cd $(date +%F)
}

# Create a temp directory and change into it.
function @mkt() {
  tpl="temp.$(date +%F).XXXXXXXXXX"
  temp=$(mktemp -d -p . $tpl)
  cd $temp
}
