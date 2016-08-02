#!/usr/bin/env tclsh

# TCLLIBPATH is supposed to be a tcl list.
# Having a path with colons isn't going to help auto_path.
# This will clear up the path.
puts [join [split $env(TCLLIBPATH) :]]
