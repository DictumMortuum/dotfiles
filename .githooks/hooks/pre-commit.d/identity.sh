#!/bin/bash

__identity() {
    git config --get --local remote.origin.url | grep $1 > /dev/null

    if [ $? -eq 0 ]; then
      git config --local user.name $2
      git config --local user.email $3
    fi
}

__identity "github"  "DictumMortuum" "theio.vrefos@gmail.com"
__identity "openbet" "draviolo"      "dimitris.raviolos@openbet.com"
