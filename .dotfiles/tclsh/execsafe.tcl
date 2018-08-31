package provide execsafe 1.0

namespace eval execsafe {
  rename exec _exec

  proc exec args {
    set status [catch {_exec {*}$args} result]
    stat $status $result
    return $status
  }

  # http://wiki.tcl.tk/1039

  proc stat {status result} {
    if {$status == 0} {
      # The command succeeded, and wrote nothing to stderr.
      # $result contains what it wrote to stdout, unless you
      # redirected it
    } elseif {[string equal $::errorCode NONE]} {
      # The command exited with a normal status, but wrote something
      # to stderr, which is included in $result.
    } else {
      switch -exact -- [lindex $::errorCode 0] {
        CHILDKILLED {
          foreach {- pid sigName msg} $::errorCode break
          # A child process, whose process ID was $pid,
          # died on a signal named $sigName.  A human-
          # readable message appears in $msg.
        }
        CHILDSTATUS {
          foreach {- pid code} $::errorCode break
          # A child process, whose process ID was $pid,
          # exited with a non-zero exit status, $code.
        }
        CHILDSUSP {
          foreach {- pid sigName msg} $::errorCode break
          # A child process, whose process ID was $pid,
          # has been suspended because of a signal named
          # $sigName.  A human-readable description of the
          # signal appears in $msg.
        }
        POSIX {
          foreach {- errName msg} $::errorCode break
          # One of the kernel calls to launch the command
          # failed.  The error code is in $errName, and a
          # human-readable message is in $msg.
        }
      }
    }
  }
}
