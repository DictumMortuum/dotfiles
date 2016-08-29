# prompt:
# %F => color dict
# %f => reset color
# %~ => current path
# %* => time
# %n => username
# %m => shortname host
# %(?..) => prompt conditional - %(condition.true.false)
# terminal codes:
# \e7   => save cursor position
# \e[2A => move cursor 2 lines up
# \e[1G => go to position 1 in terminal
# \e8   => restore cursor position
# \e[K  => clears everything after the cursor on the current line
# \e[2K => clear everything on the current line

# vcs_info:
# %a => action
# %b => branch
# %c => staged
# %i => revision
# %m => misc
# %r => base-name
# %s => vcs
# %u => unstaged
# %Q => quilt
# %R => base
# %S => subdir

autoload -Uz add-zsh-hook
autoload -Uz vcs_info

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' enable git svn cvs
zstyle ':vcs_info:*' formats "%F{blue}%s %b%m %c%u%f"
zstyle ':vcs_info:*' actionformats "%F{blue}%s %b%m %c%u%a%f"
zstyle ':vcs_info:cvs*+set-message:*' hooks cvs-tag
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

zstyle ':vcs_info:*:*' unstagedstr '+'
zstyle ':vcs_info:*:*' stagedstr '-'

# Use cvs tag instead of branch
function +vi-cvs-tag() {
  if [[ -f ./CVS/Tag ]]; then
    hook_com[branch] = $(< ./CVS/Tag)
  else
    hook_com[branch] = "trunk"
  fi
}

### git: Show marker (T) if there are untracked files in repository
# Make sure you have added staged to your 'formats':  %c
function +vi-git-untracked(){
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
    git status --porcelain | fgrep '??' &> /dev/null ; then
    # This will show the marker if there are any untracked files in repo.
    # If instead you want to show the marker only if there are untracked
    # files in $PWD, use:
    #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
    hook_com[unstaged]+='?'
  fi
}

add-zsh-hook precmd vcs_info

### Needed for a pretty prompt
#setopt prompt_subst # Enables additional prompt extentions
#autoload -U colors && colors    # Enables colours

### My default prompt
PROMPT='%F{blue}%n%f at %F{magenta}%m%f in %F{cyan}%~%f '
### My default prompt's right side
RPROMPT='${vcs_info_msg_0_}'

### My prompt for loops
PROMPT2='{%_}  '

### My prompt for selections
PROMPT3='{ … }  '

### So far I don't use "setopt xtrace", so I don't need this prompt
#PROMPT4=''
