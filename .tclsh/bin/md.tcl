#!/usr/bin/tclsh

proc headings {text} {
  foreach {re rp} {
    "^#### " "##### "
    "^### "  "#### "
    "^## "   "### "
    "^# "    "## "
  } {
    set text [regsub -all -line $re $text $rp]
  }

  return $text
}

proc readfile {name} {
  set fp [open $name r]
  set output [read $fp]
  close $fp
  return $output
}

proc replace {files {level 0} } {
  foreach f $files {
    if {[file isdirectory $f]} {
      cd $f
      lappend output [replace [lsort [glob *.md]] [expr {$level + 1}]]
      cd ..
    } else {
      lappend output [readfile $f]
    }
  }

  set output [join $output "\n"]

  if {$level != 0} {
    set output [headings $output]
  }

  foreach {re name} [regexp -inline -all {{>([\.\d\w]+)}} $output] {
    set output [regsub $re $output [replace $name $level]]
  }

  return $output
}

puts [replace index.md]