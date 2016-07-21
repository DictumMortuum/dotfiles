__compile_ssh_config () {

  if [ -f "$HOME/.ssh/config" ]; then
    return
  fi

  echo "ssh config not found. Generating..."
  cat $HOME/.ssh/*.config > $HOME/.ssh/config
}

__compile_ssh_config
