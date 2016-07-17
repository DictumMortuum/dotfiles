ZSH="$HOME/.dotfiles/oh-my-zsh"

main() {
	cd $ZSH/custom
	ln -s $HOME/.zsh/cvs.zsh

  if [ ! -d themes ]
  then
    mkdir themes
  fi

  cd themes
  ln -s $HOME/.zsh/anmol.zsh-theme
  cd ..

  if [ ! -d plugins ]
  then
    mkdir plugins
  fi

  cd plugins
  ln -s $HOME/.zsh/zsh-syntax-highlighting
	cd
}

main
