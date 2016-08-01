# Make directory and change into it.
function @mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Create a directory like "year-month-day" (i.e. 2008-08-31)
function @mkd() {
  mkdir `date +%F` && cd `date +%F`
}

# Change file extensions recursively in current directory
function @extension() {
  foreach f (**/*.$1)
    mv $f $f:r.$2
  end
}
