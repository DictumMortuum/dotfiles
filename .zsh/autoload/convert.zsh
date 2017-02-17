require convert && return 1

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
  #sensible-browser ./index.html
}
