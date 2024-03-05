# /usr/bin/env zsh
# vim: ft=zsh :
# Requirements
#

if [[ "$TERM" == 'dumb' ]]; then
  return 1
fi

#
# Options
#

setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
setopt ALWAYS_TO_END       # Move cursor to the end of a completed word.
setopt AUTO_MENU           # Show completion menu on a successive tab press.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH    # If completed parameter is a directory, add a trailing slash.
setopt EXTENDED_GLOB       # Needed for file modification glob modifiers with compinit
setopt CASE_GLOB           # Case sensitive globbing
unsetopt MENU_COMPLETE     # Do not autoselect the first completion entry.
unsetopt FLOW_CONTROL      # Disable start/stop characters in shell editor.

#
# Styles
#

# better matching
#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# Use caching to make completion for commands such as dpkg and apt usable.
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${ZDOTDIR:-$HOME}/.zcompcache"

# automatically load bash completion functions
autoload -U +X bashcompinit && bashcompinit

#
# Init
#

# Load and initialize the completion system ignoring insecure directories with a
# cache time of 20 hours, so it should almost always regenerate the first time a
# shell is opened each day.
autoload -Uz compinit
_comp_files=(${ZDOTDIR:-$HOME}/.zcompdump(Nmh-20))
if (( $#_comp_files )); then
  compinit -i -C
else
  compinit -i
fi
[[ ${ZDOTDIR:-$HOME}/.zcompdump.zwc -nt ${ZDOTDIR:-$HOME}/.zcompdump ]] || zcompile -R -- $ZDOTDIR/.zcompdump
unset _comp_files
