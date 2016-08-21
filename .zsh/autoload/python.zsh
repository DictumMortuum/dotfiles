#
# Usage: @serve [port]
#
function @serve() {
  version=$(python --version 2>&1)
  echo "Using $version ..."
  if [[ $version == *2.* ]]; then
    module="SimpleHTTPServer"
  elif [[ $version == 3.* ]]; then
    module="http.server"
  fi
  python -m $module $1
}
