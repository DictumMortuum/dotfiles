# rlwrap tclsh to get autocomplete and command history
alias tclsh="rlwrap -z $HOME/.tclsh/autocomplete tclsh"

# update path
PATH="$HOME/.tclsh/bin:$PATH"

# This path will be added to auto_path tcl global.
# It will check that folder and its subfolders for pkgIndex.tcl files to source.
# If a package is required.
export TCLLIBPATH="$HOME/.tclsh:$TCLLIBPATH"

TCLLIBPATH=$(tcllibpath.tcl)
