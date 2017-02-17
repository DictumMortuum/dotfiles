require python && return 1

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
  echo "http://localhost:${1:-8000}"
  python -m $module $1
}
