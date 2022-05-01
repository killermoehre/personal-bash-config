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
    /usr/local/bin/brew bundle --global
  fi
  /usr/local/bin/brew link python3
fi
