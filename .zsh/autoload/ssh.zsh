__compile_ssh_config () {

  if [ -f "$HOME/.ssh/config" ]; then
    return
  fi

  cat $HOME/.ssh/*.config > $HOME/.ssh/config
}

__compile_ssh_config
