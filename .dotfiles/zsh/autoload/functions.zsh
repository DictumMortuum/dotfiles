# rfc2396 url encoding (by Bart Schaefer)
function @urlencode() {
  setopt localoptions extendedglob
  input=( ${(s::)1} )
  print ${(j::)input/(#b)([^A-Za-z0-9_.--version\'\(\)-])/%$(([##16]#match))}
}

# Create a temp directory and change into it.
function @mkt() {
  tpl="temp.$(date +%F).XXXXXXXXXX"
  temp=$(mktemp -d -p . $tpl)
  cd $temp
}

function system-update() {
  if [[ $SYSTEM == Ubuntu ]]; then
    sudo apt-get --yes update
    sudo apt-get --yes upgrade
    sudo apt-get --yes autoclean
    sudo apt-get --yes autoremove
  fi
}
