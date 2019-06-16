#!/bin/bash

GIT_DIR=$1
GIT_BRANCH=${2:-master}
USER=$(id -un)
HOST=$(hostname)
THIS=$(basename $0)
ID=$(id -u)

export XDG_RUNTIME_DIR=/run/user/$ID
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$ID/bus

git -C $GIT_DIR pull origin ${GIT_BRANCH}
git -C $GIT_DIR add -A
git -C $GIT_DIR commit -m "${USER}@${HOST}" && notify-send "${THIS}" "${GIT_DIR}"
git -C $GIT_DIR push origin ${GIT_BRANCH}
