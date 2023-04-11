#!/bash
if test -f /proc/version; then
    alias vim='nvim'
else
    if type -P vimr &> /dev/null; then
        alias vim='vimr'
    else
        alias vim='nvim'
    fi
fi
