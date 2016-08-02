package provide combinations 1.0

namespace eval combinations {

  # Generates a combination list
  # get 2 a b c => {a b} {a c} {b c}

  proc get {size args} {
    if {$size == 0} {
      return [list [list]]
    }

    set retval [list]

    for {set i 0} {($i + $size) <= [llength $args]} {incr i} {
      set first [lindex $args $i]
      set rest  [lrange $args [expr {$i + 1}] end]
      foreach subset [get [expr {$size - 1}] {*}$rest] {
        lappend retval [linsert $subset 0 $first]
      }
    }
    return $retval
  }
}
