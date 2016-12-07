# Path to your oh-my-zsh installation.
export ZSH="$HOME/.dotfiles/oh-my-zsh"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="dictummortuum"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM="$HOME/.zsh/custom"

# ENVIRONMENT SETUP
source $HOME/.zsh/default.zsh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-syntax-highlighting)
[[ $HOSTNAME == dev* ]] && plugins+=(openbet)
[[ $HOSTNAME == work ]] && plugins+=(openbet-drupal)

# User configuration
source $ZSH/oh-my-zsh.sh

BASE16_SHELL=$HOME/.dotfiles/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# ALIASES / FUNCTIONS
foreach file in $(ls $HOME/.zsh/autoload); do
  # http://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash
  comm="${file%.*}"
  # http://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script
  type $comm >/dev/null 2>&1 && source $HOME/.zsh/autoload/$file
done

# http://www.zsh.org/mla/users/2002/msg00496.html
# http://zshwiki.org/home/cfg/zyrnix
# I don't know why this doesn't work in my cvs.zsh file.
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'

# condense PATH entries
PATH=$(path.tcl)
