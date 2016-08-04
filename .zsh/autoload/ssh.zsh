@ssh_compile () {
  if [[ $# -eq 1 ]] && [[ $1 = -f ]]; then
    rm $HOME/.ssh/config
  fi

  if [ -f "$HOME/.ssh/config" ]; then
    return
  fi

  echo "Generating ssh config ..."
  cat $HOME/.ssh/*.config > $HOME/.ssh/config
}

@ssh_push () {
  local _host

  if [ ! -f "$HOME/.ssh/id_rsa.pub" ]; then
    echo "$HOME/.ssh/id_rsa.pub doesn't exist."
    return
  fi

  for _host in "$@"; do
    echo "Copying to $_host"
    ssh $_host 'cat >> ~/.ssh/authorized_keys' < $HOME/.ssh/id_rsa.pub
  done
}

@ssh_compile
