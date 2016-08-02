foreach lib {
  combinations
  permutations
} {
  package ifneeded $lib 1.0 [list source [file join $dir $lib.tcl]]
}
