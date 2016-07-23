#!/usr/bin/tclsh

#
# Determines user.name and user.email from remote repository URL.
#

proc identity {repo user email} {
  if {![catch {
    exec git config --get --local remote.origin.url | grep $repo
  } msg]} {
    exec git config --local user.name $user
    exec git config --local user.email $email
  }
}

foreach {repo user email} [exec git config --get-all hooks.user] {
  identity $repo $user $email
}
