require dbschema && return 1

# $1 should be:
# -f for functions
# -t for tables
function @dbschema() {
  item=$2:l
  dbschema $1 $2
}
