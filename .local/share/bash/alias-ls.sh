#!/hint/bash
if type -p eza &> /dev/null; then
    alias ls='eza --colour=auto --icons '
fi