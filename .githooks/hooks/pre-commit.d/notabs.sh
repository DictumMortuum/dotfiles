#!/bin/bash

#
# Detects if staged items contain lines starting with a tab.
#

if [[ $(git config hooks.notabs) -eq "true" ]]; then
  if git diff --cached | grep -P '^\+\t' > /dev/null ; then
    echo "pre-commit: tabs detected in commit."
    exit 1
  fi
fi
