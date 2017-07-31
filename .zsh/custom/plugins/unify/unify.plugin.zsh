[[ $HOSTNAME == apparatus ]] && return 1

export ftp_proxy=ftp://172.28.12.5:8080/
export http_proxy=http://172.28.12.5:8080/
export https_proxy=http://172.28.12.5:8080/
export no_proxy='localhost,127.0.0.0/8,::1,*.global-ad.net,*.global-intra.net,*.unify-ath.net,10.0.0.0/8'
alias git_osv="/home/rd905075/.dotfiles/bin/git_osv.sh --gitlocal /home/rd905075/Code/production "

function @unify_proxy() {
  git config --global http.proxy $http_proxy
  npm config set proxy $http_proxy
  npm config set https-proxy $https_proxy
}
