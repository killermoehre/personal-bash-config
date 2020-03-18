#!/bash
if test -f /proc/version; then
    alias vim='nvim'
else
    alias vim='mvim'
fi
