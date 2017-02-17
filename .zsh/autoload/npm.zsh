require npm && return 1

# global npm configuration
export NPM_CONFIG_PREFIX="$HOME/.dotfiles/node_modules"

# update path
PATH="$HOME/.dotfiles/node_modules/bin:$PATH"
