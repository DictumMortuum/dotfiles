foreach lib {
  combinations
  permutations
  work
  githook
  execsafe
  transactionify
} {
  package ifneeded $lib 1.0 [list source [file join $dir $lib.tcl]]
}
