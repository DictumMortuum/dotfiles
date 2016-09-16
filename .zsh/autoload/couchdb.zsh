function @couchdb_cors() {
  # $1 is in the form of http://adminname:password@localhost:5984
  curl -X PUT $1/_config/httpd/enable_cors -d '"true"'
  curl -X PUT $1/_config/cors/origins -d '"*"'
  curl -X PUT $1/_config/cors/credentials -d '"true"'
  curl -X PUT $1/_config/cors/methods -d '"GET, PUT, POST, HEAD, DELETE"'
  curl -X PUT $1/_config/cors/headers -d '"accept, authorization, content-type, origin, referer, x-csrf-token"'
}

function @couchdb_instance() {
  sudo couchdb -a $HOME/.couchdb/${1}.ini
}
