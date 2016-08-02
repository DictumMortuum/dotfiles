foreach {lib version} {
  combinations 1.0
  permutations 1.0
} {
  package ifneeded $lib $version [list source [file join $dir $lib.tcl]]
}
