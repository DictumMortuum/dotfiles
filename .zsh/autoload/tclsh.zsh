require tclsh && return 1

# rlwrap tclsh to get autocomplete and command history
# alias tclsh="rlwrap -z $HOME/.tclsh/autocomplete tclsh"
alias tclsh="rlwrap tclsh"

# update path
PATH="$DOT_HOME/.tclsh/bin:$PATH"

# This path will be added to auto_path tcl global.
# It will check that folder and its subfolders for pkgIndex.tcl files to source.
# If a package is required.
export TCLLIBPATH="$DOT_HOME/.tclsh:$DOT_HOME/Code:$TCLLIBPATH"
type tcllibpath.tcl >/dev/null 2>&1 && TCLLIBPATH=$(tcllibpath.tcl)
