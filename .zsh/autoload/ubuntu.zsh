system Ubuntu && return 1

function apt-update() {
  sudo apt-get --yes update
  sudo apt-get --yes upgrade
  sudo apt-get --yes autoclean
  sudo apt-get --yes autoremove
}