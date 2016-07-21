_icons () {
  cd $HOME/.icons/yltra-flat-icon-theme
  git checkout master
  git pull origin master
  cd
}

_themes () {
  cd $HOME/.themes/Flatabulous
  git checkout master
  git pull origin master
  cd
}

_dotfiles () {
  cd $HOME/.dotfiles/NARKOZ
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

_vim () {
  cd $HOME/.vim
  if [ ! -d backups ]; then
    mkdir backups
  else
    echo "already exists"
  fi
  cd

  vim +PluginInstall +qall
}

_init () {
  git init .
  git remote add -t \* -f origin https://github.com/DictumMortuum/dotfiles.git
  git checkout master
  git submodule init
  git submodule update
  _icons
  _themes
  _dotfiles
  _vim
  _zsh
}

_zsh () {
  cd $HOME/.zsh/custom/plugins/zsh-syntax-highlighting
  git checkout master
  git pull origin master

}

if [ "$#" -eq 1 ]; then
  $1
else
  _init
fi
