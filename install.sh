preinstall() {
  sudo add-apt-repository --yes ppa:webupd8team/atom
  sudo apt-get update
  sudo apt-get install --yes git zsh vim unity-tweak-tool tcl nodejs npm curl wget cvs ssh gawk atom
}

install() {
  git init .
  git remote add -t \* -f origin git@github.com:DictumMortuum/dotfiles.git
  git checkout master
  git submodule update --init --recursive
  vim +PluginInstall +qall
  npm install
}

main() {
  preinstall
  install
}

main
