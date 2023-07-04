#!/usr/bin/env bash

resize() {
    old="$(stty -g)"
    stty raw -echo min 0 time 5
    printf '\0337\033[r\033[999;999H\033[6n\0338' > /dev/tty
    IFS='[;R' read -r _ rows cols _ < /dev/tty
    stty "$old"
    stty cols "$cols" rows "$rows"
}

if ! [[ "${PROMPT_COMMAND:-}" =~ resize ]]; then
    PROMPT_COMMAND="resize${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
fi
