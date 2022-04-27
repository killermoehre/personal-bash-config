#!/usr/bin/env bash

export PS0=''
export PS1='\[\033]0;\u@\H:\W\007\]'
if [[ "$(type -t iterm2_prompt_mark)" == 'function' ]]; then
    export PS1="$PS1"'\[$(iterm2_prompt_mark)\]\$ '
else
    export PS1="$PS1"'[\u@\H:\W]\$ '
fi
export PS1='\$ '
export PS2='> '
export PS3='> '
export PS4='+ '
export PROMPT_COMMAND="history -a;printf '\033]0;\a';${PROMPT_COMMAND:- $PROMPT_COMMAND}"
