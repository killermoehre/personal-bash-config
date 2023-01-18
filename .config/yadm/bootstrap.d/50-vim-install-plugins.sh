#!/usr/bin/env bash

set -euo pipefail

declare _vim='vim'
if hash mvim &> /dev/null; then
    _vim='mvim'
fi
if hash nvim &> /dev/null; then
    _vim='nvim'
fi

exec "$_vim" --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
