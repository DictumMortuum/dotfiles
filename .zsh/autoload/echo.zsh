# rfc2396 url encoding (by Bart Schaefer)
function @urlencode() {
    setopt localoptions extendedglob
    input=( ${(s::)1} )
    print ${(j::)input/(#b)([^A-Za-z0-9_.--version\'\(\)-])/%$(([##16]#match))}
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
