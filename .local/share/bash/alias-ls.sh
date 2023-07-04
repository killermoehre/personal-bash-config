#!/hint/bash
if type -p exa &> /dev/null; then
    alias ls='exa --colour=auto --icons '
fi