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

# generate thumbnails page ;)
function @thumbs() {
  echo "
  <!DOCTYPE html>
  <html><head><title>Images from $PWD</title></head>
  <body>" > index.html
  for f in *.(gif|jpeg|jpg|png)
  do
    convert -size 100x200 "$f" -resize 100x200 thumb-"$f"
    echo "    <a href=\"$f\"><img src=\"thumb-$f\"></a>" >> index.html
  done
  echo "</body></html>" >> index.html
  sensible-browser ./index.html
}
