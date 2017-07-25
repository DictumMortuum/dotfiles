[[ $HOSTNAME == apparatus ]] && exit 0

export ftp_proxy=ftp://172.28.12.5:8080/
export http_proxy=http://172.28.12.5:8080/
export https_proxy=http://172.28.12.5:8080/
export no_proxy='localhost,127.0.0.0/8,::1,*.global-ad.net,*.global-intra.net,*.unify-ath.net,10.0.0.0/8'
alias git_osv="/home/rd905075/.dotfiles/bin/git_osv.sh --gitlocal /home/rd905075/Code/production "

if [[ ! $(dot s | grep .gitconfig) ]]; then
  git config --global http.proxy $http_proxy
fi

if [[ ! $(dot s | grep .npmrc) ]]; then
  npm config set proxy $http_proxy
  npm config set https-proxy $https_proxy
fi