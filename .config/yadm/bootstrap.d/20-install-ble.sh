#!/usr/local/bin/bash

mkdir -p "$HOME/.local/lib/"
pushd "$HOME/.local/lib" || exit 1
if test -d ble.sh; then
    git -C ble.sh pull
else
    git clone --recursive https://github.com/akinomyoga/ble.sh.git
fi
/usr/local/bin/gmake -C ble.sh install PREFIX="$HOME/.local"
popd || exit 0
