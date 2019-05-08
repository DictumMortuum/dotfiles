#!/bin/bash

GIT_DIR=$1
GIT_BRANCH=${2:-master}
USER=$(id -un)
HOST=$(hostname)

git -C $GIT_DIR pull origin ${GIT_BRANCH}
git -C $GIT_DIR add -A
git -C $GIT_DIR commit -m "${USER}@${HOST}"
git -C $GIT_DIR push origin ${GIT_BRANCH}
