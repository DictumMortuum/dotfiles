#!/usr/bin/tclsh

proc msec {} {
  return [exec date +%3N]
}

proc parse {d} {
  return [exec date +%Y%M%d_%H%m%S -d $d]
}

proc metadata {f} {
  if {[catch {
    set dates [exec identify -format "%\[*date*\]" $f]
  } msg]} {
    return {}
  }

  set temp {}

  foreach d [split $dates \n] {
    lappend temp {*}[split $d =]
  }

  return $temp
}

proc stat {f} {
  file stat $f options
  return [list \
    stat:change [clock format $options(ctime) -format "%Y%M%d_%H%m%S"][msec] \
    stat:modify [clock format $options(mtime) -format "%Y%M%d_%H%m%S"][msec] \
  ]
}

proc filename {f} {
  set temp [lindex [regexp -all -inline {(\d\d\d\d[012][0-9][0-3][0-9]_[0-2][0-9][0-5][0-9][0-5][0-9])} $f] 0]

  if {$temp == ""} {
    return {}
  } else {
    return [list file:name $temp[msec]]
  }
}

proc main {f} {
  set lst [list {*}[metadata $f] {*}[stat $f] {*}[filename $f]]

  if {[dict exists $lst exif:DateTime]} {
    dict set lst exif:DateTime [string map {: "" " " "_"} [dict get $lst exif:DateTime]][msec]
  }

  if {[dict exists $lst exif:DateTimeOriginal]} {
    dict set lst exif:DateTimeOriginal [string map {: "" " " "_"} [dict get $lst exif:DateTimeOriginal]][msec]
  }

  if {[dict exists $lst exif:DateTimeDigitized]} {
    dict set lst exif:DateTimeDigitized [string map {: "" " " "_"} [dict get $lst exif:DateTimeDigitized]][msec]
  }

  if {[dict exists $lst date:create]} {
    dict set lst date:create [parse [dict get $lst date:create]][msec]
  }

  if {[dict exists $lst date:modify]} {
    dict set lst date:modify [parse [dict get $lst date:modify]][msec]
  }

  if {[dict exists $lst xap:CreateDate]} {
    dict set lst xap:CreateDate [parse [dict get $lst xap:CreateDate]][msec]
  }

  set lst [lsort -stride 2 -index 1 $lst]
  #puts "# $lst"

  if {[dict exists $lst xap:CreateDate]} {
    return [dict get $lst xap:CreateDate]
  }

  if {[dict exists $lst exif:DateTimeOriginal]} {
    return [dict get $lst exif:DateTimeOriginal]
  }

  if {[dict exists $lst file:name]} {
    return [dict get $lst file:name]
  }

  return [lindex $lst 1]
}

foreach f $argv {
  set ext [file extension $f]

  set f [string map {
    "\)" "\\\)"
    "\(" "\\\("
    " "  "\\ "
  } $f]

  if {[catch {
    set name [main $f]$ext
  } msg]} {
    puts "# failed: $f"
  } else {
    puts "# $name"
    if {[string range $f 0 14] != [string range $name 0 14]} {
      puts "\[ ! -f $name \] && mv $f $name"
    }
  }
}
