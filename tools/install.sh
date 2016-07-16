git init .
git remote add -t \* -f origin https://github.com/DictumMortuum/dotfiles.git
git checkout master
git submodule init
git submodule update
git submodule foreach git pull origin master
