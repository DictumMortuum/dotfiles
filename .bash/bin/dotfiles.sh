#!/usr/bin/env bash
# git wrapper for the dotfiles directory

export GIT_DIR="${DOTFILES_GIT_DIR:-$HOME}/.git"
export GIT_WORK_TREE="${DOTFILES_GIT_WORK_TREE:-$HOME}"
git "$@"
