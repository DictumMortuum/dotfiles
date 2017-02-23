# Plugins
[[ $ZSH_VERSION == <5->* ]] && source $PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

export BASE16_THEME=base16-ashes
. $HOME/.base16_theme

_base16() {
  local script=$1
  local theme=$2
  [ -f $script ] && . $script
  ln -fs $script $HOME/.base16_theme
  export BASE16_THEME=${theme}
  echo -e "if \0041exists('g:colors_name') || g:colors_name != 'base16-$theme'\n  colorscheme base16-$theme\nendif" >| ~/.vimrc_background
}

alias base16_ashes="_base16 \"$HOME/.dotfiles/base16-shell/scripts/base16-ashes.sh\" ashes"
