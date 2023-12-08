# vim:set ft=zsh :

if [[ -e "$HOME/.local/share/zsh/completions" ]]; then
  fpath+="$HOME/.local/share/zsh/completions"
fi

if [[ -e "/usr/local/share/zsh/vendor-completions" ]]; then
  fpath+="/usr/local/share/zsh/vendor-completions"
fi

if [[ -e "$HOMEBREW_PREFIX/share/zsh/site-functions" ]]; then
  fpath+="$HOMEBREW_PREFIX/share/zsh/site-functions"
fi

if [[ -e "/usr/share/zsh/vendor-completions" ]]; then
  fpath+="/usr/share/zsh/vendor-completionsh"
fi

if [[ -e "/usr/share/zsh/site-functions" ]]; then
  fpath+="/usr/share/zsh/site-functions"
fi

if [[ -e "$XDG_DATA_HOME/zsh/plugins/zsh-completions/src" ]]; then
  # load completions functions
  fpath+="$XDG_DATA_HOME/zsh/plugins/zsh-completions/src"
fi
