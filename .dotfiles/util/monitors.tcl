#!/usr/bin/tclsh

proc get_monitors {} {
  return [exec xrandr -q | grep " connected" | cut -d " " -f1]
}

proc permutations {n args} {

  if {$n == 1} {
    return $args
  }

  set length [llength $args]
  set l [list]

  for {set i 0} {$i < $length} {incr i} {
    set tail [lreplace $args $i $i]
    set init [lindex $args $i]

    foreach c [eval permutations [expr {$n - 1}] $tail] {
      lappend l [concat $init $c]
    }
  }

  return $l
}

set m [get_monitors]
puts [join [permutations [llength $m] {*}$m] \n]
