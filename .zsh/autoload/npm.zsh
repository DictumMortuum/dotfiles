require npm && return 1

# global npm configuration
export NPM_CONFIG_PREFIX="$DOT_HOME/.dotfiles/node_modules"

# update path
PATH="$DOT_HOME/.dotfiles/node_modules/bin:$PATH"
