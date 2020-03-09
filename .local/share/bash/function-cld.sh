#!/usr/bin/env bash

function cld() {
    exec {fd_ccloud}>>/dev/stdout
    . <(ccloud-multitool --stdout-fd $fd_ccloud "$@")
    exec {fd_ccloud}>&-
}
alias mycd='cld -u '
