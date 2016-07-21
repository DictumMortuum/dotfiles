# Make directory and change into it.

function mkdircd() {
  mkdir -p "$1" && cd "$1";
}

# Change file extensions recursively in current directory
#
#   change-extension erb haml

function change-extension() {
  foreach f (**/*.$1)
    mv $f $f:r.$2
  end
}
