#Get more characters from http://copypastecharacter.com/
local ret_status="%(?:%{$fg_bold[blue]%}#:%{$fg_bold[red]%}#%s)"

function cvs_prompt_info() {
  if [[ -d "CVS" ]] && [[ -e "CVS/Tag" ]]; then
    CVS_BRANCH=$(cat CVS/Tag | cut -c 2-)
    echo "${ZSH_THEME_CVS_PROMPT_PREFIX}${CVS_BRANCH}${ZSH_THEME_CVS_PROMPT_SUFFIX}"
  fi
}

function svn_prompt_info() {
  SVN_INFO=$(svn info 2> /dev/null)
  if [ $? -eq 0 ]; then
    SVN_BRANCH=$(echo $SVN_INFO | grep 'Relative URL' | awk '{print $3}')
    SVN_REV=$(echo $SVN_INFO | grep 'Revision' | awk '{print $2}')
    echo "${ZSH_THEME_SVN_PROMPT_PREFIX}$SVN_BRANCH:$SVN_REV${ZSH_THEME_SVN_PROMPT_SUFFIX}"
  fi
}

PROMPT='${ret_status}%{$reset_color%} %{$fg[cyan]%}%n%{$reset_color%} at %{$fg[cyan]%}%m%{$reset_color%} in %{$fg[cyan]%}%~%{$reset_color%} $(cvs_prompt_info)$(svn_prompt_info)$(git_prompt_info)% %{$reset_color%}'
RPROMPT='%{$fg_bold[cyan]%}[%*]%{$reset_color%}'
ZSH_THEME_CVS_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[red]%}"
ZSH_THEME_CVS_PROMPT_SUFFIX="%{$fg[blue]%})%{$fg[red]%}%{$reset_color%}%{$reset_color%}%{$fg_bold[blue]%} "
ZSH_THEME_SVN_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[red]%}"
ZSH_THEME_SVN_PROMPT_SUFFIX="%{$fg[blue]%})%{$fg[red]%}%{$reset_color%}%{$reset_color%}%{$fg_bold[blue]%} "
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}%{$fg_bold[blue]%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[red]%}+%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}) %{$fg[red]%}-%{$reset_color%} "
