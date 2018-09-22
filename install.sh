## Installation
#curl -s https://raw.githubusercontent.com/DictumMortuum/dotfiles/master/install.sh | bash /dev/stdin
#curl -s https://raw.githubusercontent.com/DictumMortuum/dotfiles/master/install.sh | bash /dev/stdin ubuntu

ubuntu() {
  sudo apt-get update
  sudo apt-get install --yes git
  sudo apt-get install --yes zsh
  sudo apt-get install --yes vim
  sudo apt-get install --yes unity-tweak-tool
  sudo apt-get install --yes tcl
  sudo apt-get install --yes gawk
}

install() {
  git init --separate-git-dir=$HOME/dotfiles.git .
  git remote add -t \* -f origin git@github.com:DictumMortuum/dotfiles.git
  git checkout master
  git submodule update --init --recursive
  type vim >/dev/null 2>&1 && vim +PluginInstall +qall
  type npm >/dev/null 2>&1 && npm install
}

[ "$#" -ne 0 ] && $1
install
