require tclsh && return 1

# rlwrap tclsh to get autocomplete and command history
# alias tclsh="rlwrap -z $HOME/.tclsh/autocomplete tclsh"
alias tclsh="rlwrap tclsh"

# update path
PATH="$HOME/.tclsh/bin:$PATH"

# This path will be added to auto_path tcl global.
# It will check that folder and its subfolders for pkgIndex.tcl files to source.
# If a package is required.
export TCLLIBPATH="$HOME/.tclsh:$TCLLIBPATH"
type tcllibpath.tcl >/dev/null 2>&1 && TCLLIBPATH=$(tcllibpath.tcl)
