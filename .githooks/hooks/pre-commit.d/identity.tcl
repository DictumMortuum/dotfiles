#!/usr/bin/tclsh

#
# Determines user.name and user.email from remote repository URL.
# To use, add users to your gitconfig:
#
# [hooks]
#   user = repository1 username1 email1
#   user = repository2 username2 email2
#

foreach {repo user email} [exec git config --get-all hooks.user] {
  if {![catch {
    exec git config --get --local remote.origin.url | grep $repo
  } msg]} {
    exec git config --local user.name $user
    exec git config --local user.email $email
  }
}
