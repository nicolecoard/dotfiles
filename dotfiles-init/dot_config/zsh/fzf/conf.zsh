# vim: ft=zsh :

(( $+commands[fzf] )) || return

source $XDG_DATA_HOME/zsh/plugins/fzf/shell/completion.zsh
source $XDG_DATA_HOME/zsh/plugins/fzf/shell/key-bindings.zsh
