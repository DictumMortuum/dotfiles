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

[[ $ZSH_VERSION != 4.* ]] && return 1
autoload -U colors && colors
DICTUM_USER="%B%{$fg[8]%}%n%f%b"
DICTUM_HOST="%B%{$fg[magenta]%}%m%f%b"
DICTUM_PROMPT="%B%{$fg[blue]%}%~%f%b"
PROMPT="$DICTUM_USER on $DICTUM_HOST in $DICTUM_PROMPT "
