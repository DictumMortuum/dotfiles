foreach lib {
  combinations
  permutations
  work
} {
  package ifneeded $lib 1.0 [list source [file join $dir $lib.tcl]]
}
