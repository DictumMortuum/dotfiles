main() {
	cd $HOME/.oh-my-zsh/custom
	ln -s $HOME/zsh/openbet.zsh
	cd themes
	ln -s $HOME/zsh/anmol.zsh-theme
	cd ../plugins
	ln -s $HOME/zsh/zsh-syntax-highlighting
	cd
}

main
