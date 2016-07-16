main() {
	cd $HOME/.oh-my-zsh/custom
	ln -s $HOME/zsh/.oh-my-zsh/custom/openbet.zsh
	cd themes
	ln -s $HOME/zsh/.oh-my-zsh/custom/themes/anmol.zsh-theme
	cd ../plugins
	ln -s $HOME/zsh/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
	cd
}

main
