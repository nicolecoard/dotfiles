#
# Options
#

HISTFILE="$HOME/.config/zsh/zsh_history"
mkdir -p "$(dirname "$HISTFILE")"


setopt BANG_HIST              # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY       # Add timestamp to history
setopt SHARE_HISTORY          # Imports new commands from the history file, and appended to the history file
setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS       # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE      # Do not record an event starting with a space.
setopt HIST_VERIFY            # Do not execute immediately upon history expansion.
setopt HIST_BEEP              # Beep when accessing non-existent history.

#
# Variables
#

HISTSIZE=10000                                          # The maximum number of events to save in the internal history.
SAVEHIST=10000                                          # The maximum number of events to save in the history file.
