#!/bin/bash

# vim: ft=sh

pushd "$HOME" || exit

system_type=$(uname -s)

if [ "$system_type" = "Darwin" ]; then
  # install homebrew if it's missing
  if ! command -v brew >/dev/null 2>&1; then
    echo "Installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  if [ -f "$HOME/.Brewfile" ]; then
    echo "Updating homebrew bundle"
    brew bundle --global
  fi
  brew services start openssl-osx-ca
  brew services start ssh-askpass
fi
