#! /bin/bash

icons () {
	cd ~/.icons/yltra-flat-icon-theme
	git checkout master
	git pull origin master
	cd
}

themes () {
	cd ~/.themes/Flatabulous
	git checkout master
	git pull origin master
	cd
}

dotfiles () {
  cd ~/.dotfiles/NARKOZ
  git checkout narkoz
  git pull origin narkoz
  cd ../Vundle.vim
  git checkout master
  git pull origin master
  cd ../oh-my-zsh
  git checkout master
  git pull origin master
  cd
}

vim () {
  # Persistent undo folder
  if [ -d backups ]; then
    mkdir backups
  else
    echo "already exists"
  fi

	vim +PluginInstall +qall
}

init () {
	git init .
	git remote add -t \* -f origin https://github.com/DictumMortuum/dotfiles.git
	git checkout master
	git submodule init
	git submodule update
  icons
  themes
  dotfiles
  vim
  zsh
}

zsh () {
	ZSH="$HOME/.dotfiles/oh-my-zsh"

	cd $HOME/.zsh/zsh-syntax-highlighting
	git checkout master
	git pull origin master

	cd $ZSH/custom
	ln -s $HOME/.zsh/cvs.zsh

	if [ ! -d themes ]; then
		mkdir themes
	fi

	cd themes
	ln -s $HOME/.zsh/anmol.zsh-theme

	if [ ! -d plugins ]; then
		mkdir plugins
	fi

	cd plugins
	ln -s $HOME/.zsh/zsh-syntax-highlighting
	cd
}

if [[ $# -eq 1 ]]; then
  $1
else
  init
fi

