package provide githook 1.0

namespace eval githook {

  proc location arg {
    set map {
      .tcl .tclsh
      .sh  .bash
    }
    return [string map $map $arg]
  }

  proc logger arg {
    set log [split $arg \n]
    set n [expr {[llength $log] - 1}]

    # If the child failed, then don't print the last line
    # As it will just contain "child process exited abnormally"
    for {set i 0} {$i < $n} {incr i} {
      puts [lindex $log $i]
    }
  }

  proc source arg {
    set retval 0

    foreach hook $arg {
      set extension [file extension $hook]
      set path [file join $::env(HOME) [location $extension] bin $hook]
      set status [catch {exec $path} result]

      if {$status != 0} {
        logger $result
        set retval 1
      }
    }

    exit $retval
  }
}
