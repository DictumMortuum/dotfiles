#!/usr/bin/awk -f

#
# @field
# Returns the @field'th field from the end.
# Usage: ./backwards.awk -v field=1
#

BEGIN {
  if (field == "") {
    field = 0;
  }
}

{
	print $(NF-field)
}

