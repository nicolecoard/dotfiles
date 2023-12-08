#!/bin/zsh
# vim: set ft=sh:
# shellcheck shell=bash

# OS Name
OS_NAME="$(uname)"
ARCH="$(uname -m)"

if [ "$OS_NAME" = "Darwin" ] && [ "$ARCH" = "arm64" ]; then
  BREW="/opt/homebrew/bin/brew"
fi
if [ "$OS_NAME" = "Darwin" ] && [ "$ARCH" != "arm64" ]; then
  BREW="/usr/local/bin/brew"
fi

RED="\033[1;31m"
GREEN="\033[1;32m"
NOCOLOR="\033[0m"

print_with_color() {
  local color="$1"
  local message="$2"
  echo -e "${color}$message${NOCOLOR}"
  echo -e "\n"
  sleep 3
}

print_error() {
  local message="$1"
  print_with_color "$RED" "$message"
}

print_message() {
  local message="$1"
  print_with_color "$GREEN" "$message"
}

ensure_ssh_is_working() {
  print_message "Adding ssh id to ssh-agent"
  if ! ssh-add; then
    print_error "Error: could not add ssh id."
    exit 1
  fi
}

install_homebrew() {
  if [[ ! -f "$BREW" ]]; then
    print_message "Installing homebrew ... follow the prompts"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

bootstrap_chezmoi() {
  # shellcheck disable=SC2046,SC1091
  eval $($BREW shellenv zsh)
  $BREW install --force chezmoi rcmdnk/file/brew-file
  # shellcheck disable=SC1091
  if [[ -f "$HOMEBREW_PREFIX/etc/brew-wrap" ]]; then
    export HOMEBREW_BREWFILE_ON_REQUEST=1
    source "$HOMEBREW_PREFIX/etc/brew-wrap"
  fi
}

setup_gnupg() {
  # shellcheck disable=2154
  if [[ -n "$TRUSTED_GPGKEY_FINGREPRINT" ]]; then
    $BREW install --force gnupg pinentry-mac git-crypt
    gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys "$TRUSTED_GPGKEY_FINGREPRINT"
    echo "$key:6:" | gpg --import-ownertrust
    gpg --card-status
    gpg --list-secret-keys
  fi
}

decrypt_files() {
  gitattributes_file="$PWD/.gitattributes"
  [[ ! -f "$gitattributes_file" ]] && return
  if grep "git-crypt" "$gitattributes_file" &>/dev/null; then
    git-crypt unlock || (
      print_error "Error: Could not decrypt files"
      exit 1
    )
  fi
}

chezmoi_apply() {
  print_message "Applying chezmoi configuration."
  chezmoi apply
}

ensure_ssh_is_working
install_homebrew
bootstrap_chezmoi
setup_gnupg
decrypt_files
chezmoi_apply
