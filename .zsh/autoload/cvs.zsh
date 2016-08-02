export CVS_RSH=ssh
export cvso=:pserver:draviolo@pserver:/cvsroot-openbet
export cvsd=:pserver:draviolo@pserver:/cvsroot
export CVSROOT=$cvsd

# Openbet naming convention
function @cvs_tag () {
  cvs -q tag S_$1
  cvs -q tag -b B_$1
  cvs -q upd -r B_$1
}
