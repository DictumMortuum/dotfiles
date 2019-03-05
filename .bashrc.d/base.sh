#!/bin/bash

PORT=4612

function ssht() {
  ssh -ND ${PORT} -v $1
}

function chromiumt() {
  chromium-browser --proxy-server="socks5://localhost:${PORT}" --host-resolver-rules="MAP * 0.0.0.0 , EXCLUDE localhost"
}
