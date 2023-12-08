# dotfile manager
alias cm="chezmoi"

# ls alternate
alias                                                   \
  l='eza -lh --group-directories-first -F'      \
  la='eza -aalhF --group-directories-first'     \
  lt='eza --tree -d -a --ignore-glob "**/.git"'

# General aliases
alias cat='bat'
alias type='type -a'
alias mkdir='mkdir -p'

# grep alternative
alias grep='rg' \
      gi='grep -i'

# quick cd
alias ".."="cd .." \
      "..."="cd ../.." \
      "...."="cd ../../.." \
      "....."="cd ../../../.."
