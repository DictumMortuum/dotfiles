#!/usr/bin/tclsh

puts [join [lsort -unique [split $env(PATH) :]] :]
