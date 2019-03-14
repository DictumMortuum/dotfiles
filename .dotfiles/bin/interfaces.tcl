#!/usr/bin/tclsh

proc get_interface {n} {
  return [exec ls /sys/class/net | grep $n | tail -n 1]
}

set fp [open /tmp/interfaces w]

if {![catch {
  set wireless [get_interface wlp]
}]} {
  puts $fp "*wireless: $wireless"
}

if {![catch {
  set wired [get_interface en]
}]} {
  puts $fp "*wired: $wired"
}

close $fp
