# Change file extensions recursively in current directory
function @extension() {
  foreach f (**/*.$1)
    mv $f $f:r.$2
  end
}
