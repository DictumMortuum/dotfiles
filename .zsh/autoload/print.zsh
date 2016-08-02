# rfc2396 url encoding (by Bart Schaefer)
function @urlencode() {
  setopt localoptions extendedglob
  input=( ${(s::)1} )
  print ${(j::)input/(#b)([^A-Za-z0-9_.--version\'\(\)-])/%$(([##16]#match))}
}
