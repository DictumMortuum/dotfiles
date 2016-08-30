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

DICTUM_USER="%F{8}%n%f"
DICTUM_HOST="%F{magenta}%m%f"
DICTUM_BRANCH="%F{8}%b%f%F{red}%m%f%c%u"
DICTUM_PROMPT="%F{blue}%~%f"
DICTUM_VCS="%F{magenta}%s%f"

DICTUM_UNTRACKED="?"
DICTUM_STAGED="-"
DICTUM_UNSTAGED="+"

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' enable git svn cvs
zstyle ':vcs_info:*' formats "%%B$DICTUM_BRANCH%%b at \
%%B$DICTUM_VCS%%b in %%B$DICTUM_PROMPT%%b "
zstyle ':vcs_info:*' actionformats "%%B$DICTUM_BRANCH|%a at \
%%B$DICTUM_VCS%%b in %%B$DICTUM_PROMPT%%b "
zstyle ':vcs_info:*' nvcsformats "%B$DICTUM_USER%b at \
%B$DICTUM_HOST%b in %B$DICTUM_PROMPT%b "
zstyle ':vcs_info:*:*' unstagedstr "$DICTUM_UNSTAGED"
zstyle ':vcs_info:*:*' stagedstr "$DICTUM_STAGED"
zstyle ':vcs_info:cvs*+set-message:*' hooks cvs-tag
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-aheadbehind git-remotebranch

# Use cvs tag instead of branch
function +vi-cvs-tag() {
  if [[ -f ./CVS/Tag ]]; then
    hook_com[branch]=$(< ./CVS/Tag)
  else
    hook_com[branch]="HEAD"
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
    hook_com[unstaged]+="$DICTUM_UNTRACKED"
  fi
}

### git: Show +N/-N when your local branch is ahead-of or behind remote HEAD.
# Make sure you have added misc to your 'formats':  %m
function +vi-git-aheadbehind() {
  local ahead behind
  local -a gitstatus

  # for git prior to 1.7
  # ahead=$(git rev-list origin/${hook_com[branch]}..HEAD | wc -l)
  ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l | tr -d ' ')
  (( $ahead )) && gitstatus+=( "+${ahead}" )

  # for git prior to 1.7
  # behind=$(git rev-list HEAD..origin/${hook_com[branch]} | wc -l)
  behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l | tr -d ' ')
  (( $behind )) && gitstatus+=( "-${behind}" )

  hook_com[misc]+=${(j::)gitstatus}
}

### git: Show remote branch name for remote-tracking branches
# Make sure you have added staged to your 'formats':  %b
function +vi-git-remotebranch() {
  local remote

  # Are we on a remote-tracking branch?
  remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
      --symbolic-full-name 2>/dev/null)/refs\/remotes\/}

  # The first test will show a tracking branch whenever there is one. The
  # second test, however, will only show the remote branch's name if it
  # differs from the local one.
  #if [[ -n ${remote} ]] ; then
  if [[ -n ${remote} && ${remote#*/} != ${hook_com[branch]} ]] ; then
    hook_com[branch]+="(${remote})"
  fi
}

add-zsh-hook precmd vcs_info

### My default prompt
PROMPT='${vcs_info_msg_0_}'
### My default prompt's right side
#RPOMPT=''
### My prompt for loops
PROMPT2='{%_}  '
### My prompt for selections
PROMPT3='{ … }  '
### So far I don't use "setopt xtrace", so I don't need this prompt
#PROMPT4=''
