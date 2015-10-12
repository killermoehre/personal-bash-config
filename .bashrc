# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

case "$TERM" in
    screen*) PROMPT_COMMAND='/bin/echo -ne "\033k\033\0134"'
esac

# Source git-prompt
source ~/.git-prompt.sh

# Colors
## Regular Text
txt_blk='\[\e[1;30m\]'
txt_red='\[\e[1;31m\]'
txt_grn='\[\e[1;32m\]'
txt_ylw='\[\e[1;33m\]'
txt_blu='\[\e[1;34m\]'
txt_pur='\[\e[1;35m\]'
txt_cyn='\[\e[1;36m\]'
txt_wht='\[\e[1;37m\]'
## Reset Color
col_off='\[\e[0m\]'

#PS1="$txt_blu[\\u$txt_wht@$txt_blu\\h $txt_wht\\W$txt_blu]$txt_wht \\$ $col_off"

# Helper for git-prompt
    # Configure git-prompt
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_DESCRIBE_STYLE="branch"
    GIT_PS1_SHOWUPSTREAM="auto git"
    GIT_PS1_SHOWCOLORHINTS=1

get_dir() {
    printf "%s" $(pwd | sed "s:$HOME:~:")
}

get_sha() {
    git rev-parse --short HEAD 2>/dev/null
}

# Build my prompt
set_prompt () {
    # Variables
    Last_Command=$?

    # Icons for Last_Command
    FancyX='\342\234\227'
    Checkmark='\342\234\223'

    # Reset PS1
    PS1=""

    # If last Command failed print a fancyX
    if [[ $Last_Command != 0 ]]; then
        PS1+="$txt_red$FancyX "
    fi

    # If root, just print the host in red. Otherwise, print the current user
    # and host in blue.
    if [[ $EUID == 0 ]]; then
        PS1+="$txt_red[\\h "
    else
        PS1+="$txt_blu[\\u$txt_wht@$txt_blu\\h "
    fi

    # Print the working directory and prompt marker in white.
    PS1+="$txt_wht\\W $col_off"

    # Add git-prompt-substitution
    PS1+="$(__git_ps1 "(%s)")"

    # End Prompt with a red bracket
    if [[ $EUID == 0 ]]; then
	PS1+="$txt_red] $txt_wht\\\$$col_off "
    else
	PS1+="$txt_blu] $txt_wht\\\$$col_off "
    fi
}
PROMPT_COMMAND='set_prompt'
