package provide permutations 1.0

namespace eval permutations {

  # Generates a permutation list
  # get 2 a b c => {a b} {a c} {b a} {b c} {c a} {c b}

  proc get {n args} {

    if {$n == 1} {
      return $args
    }

    set length [llength $args]
    set l [list]

    for {set i 0} {$i < $length} {incr i} {
      set tail [lreplace $args $i $i]
      set init [lindex $args $i]

      foreach c [eval get [expr {$n - 1}] $tail] {
        lappend l [concat $init $c]
      }
    }

    return $l
  }
}
