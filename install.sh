main () {
  git init .
  git remote add -t \* -f origin https://github.com/DictumMortuum/dotfiles.git
  git checkout master
  git submodule update --init --recursive
  vim +PluginInstall +qall
}

main
