ubuntu() {
  sudo add-apt-repository --yes ppa:webupd8team/atom
  sudo apt-get update
  sudo apt-get install --yes git
  sudo apt-get install --yes zsh
  sudo apt-get install --yes vim
  sudo apt-get install --yes unity-tweak-tool
  sudo apt-get install --yes tcl
  sudo apt-get install --yes nodejs
  sudo apt-get install --yes npm
  sudo apt-get install --yes curl
  sudo apt-get install --yes wget
  sudo apt-get install --yes cvs
  sudo apt-get install --yes ssh
  sudo apt-get install --yes gawk
  sudo apt-get install --yes atom
  apm install --no-confirm atom-material-ui
  apm install --no-confirm base16-syntax
  apm install --no-confirm file-icons
  apm install --no-confirm language-tcl
  apm install --no-confirm language-viml
  apm install --no-confirm linter
  apm install --no-confirm linter-eslint
}

install() {
  git init .
  git remote add -t \* -f origin git@github.com:DictumMortuum/dotfiles.git
  git checkout master
  git submodule update --init --recursive

  if type vim >/dev/null 2>&1; then
    vim +PluginInstall +qall
  fi

  if type npm >/dev/null 2>&1; then
    npm install
  fi
}

if [ "$#" -ne 0 ]; then
  $1
fi

install
