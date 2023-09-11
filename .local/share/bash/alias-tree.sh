#!/hint/bash
if type -p eza &> /dev/null; then
    alias tree='eza --tree --color=auto --icons '
fi