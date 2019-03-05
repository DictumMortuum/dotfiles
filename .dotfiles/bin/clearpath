#!/usr/bin/tclsh

set res {}

foreach path [lsort -unique [split $env(PATH) :]] {
  if {[file isdirectory $path]} {
    lappend res $path
  }
}

puts [join $res :]
