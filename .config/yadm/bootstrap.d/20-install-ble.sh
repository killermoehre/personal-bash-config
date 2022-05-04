#!/usr/bin/env bash

# use gmake is available, else make
declare _make=''
_make="$(type -P make)"
if type -P gmake 2> /dev/null; then
    _make="$(type -P gmake)"
fi

mkdir -p "$HOME/.local/lib/"
pushd "$HOME/.local/lib" || exit 1
if test -d ble.sh; then
    git -C ble.sh pull
else
    git clone --recursive https://github.com/akinomyoga/ble.sh.git
fi
"$_make" -C ble.sh install PREFIX="$HOME/.local"
popd || exit 0
