main () {
  git init .
  git remote add -t \* -f origin git@github.com:DictumMortuum/dotfiles.git
  git checkout master
  git submodule update --init --recursive
  vim +PluginInstall +qall
  npm install
}

main
