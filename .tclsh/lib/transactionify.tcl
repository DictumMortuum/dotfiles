package provide transactionify 1.0

namespace eval transactionify {

  # Tested for Informix 11.50
  proc process {fc fr file} {
    set fp [open $file "r"]
    set data [read $fp]
    close $fp

    # Remove procs
    regsub -all {create procedure.*end procedure} $data "" check
    # Remove multiline comments
    regsub -all {\{.*\}} $check "" check
    # Remove drop procedure statement
    regsub -all -line {drop procedure .*} $check "" check
    # Remove single line comments
    regsub -all -line {\-\-.*} $check "" check

    # If there is a begin/rollback/commit statement in whatever's left,
    # then we've got a problem
    if {![regexp {begin[a-zA-Z ]*;|commit[a-zA-Z ]*;|rollback[a-zA-Z ]*;} $check]} {
      puts $fc $data
      puts $fr $data
    # If there is a transaction outside of a proc, we have a problem.
    } else {
      puts "$file already uses transaction, not including."
    }
  }

  proc init files {
    set fr [open "rollback.sql" "w"]
    set fc [open "commit.sql" "w"]

    puts $fc "begin;"
    puts $fr "begin;"

    foreach file $files {
      process $fc $fr $file
    }

    puts $fc "commit;"
    puts $fr "rollback;"

    close $fc
    close $fr
  }
}
