#!/bin/bash

declare _bash=''
for _bash in /opt/homebrew/bin/bash /usr/local/bin/bash; do
    if test -x "$_bash"; then
        sudo chsh -s "$_bash" "$USER"
        break
    fi
done
