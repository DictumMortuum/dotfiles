package provide transactionify 1.0

namespace eval transactionify {

  proc process {fc fr file} {
    set fp [open $file "r"]
    set data [read $fp]
    close $fp

    set transaction [regexp -all {begin.*(commit|rollback)} $data]
    set trans_in_proc [regexp -all {create procedure.*begin.*(commit|rollback).*end procedure} $data]

    # If there is a transaction in a stored proc, we're ok.
    # If there is no transaction, we're ok.
    if { ($transaction && $trans_in_proc) || ! $transaction} {
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
