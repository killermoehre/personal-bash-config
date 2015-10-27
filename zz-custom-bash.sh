#!/bin/bash
# zz-custom-bash.sh
# Please place this file in /etc/profile.d/
#
# Maintainer: danielschier84<at>gmail.com
# Version: 0.2

##########################################
# Shell-Options                          #
##########################################
shopt -s autocd # yeah autocd for "/etc" = "cd /etc"
shopt -s checkwinsize # check window size and resize
shopt -s cdspell # autocorrect minor spelling errors
shopt -s dirspell # bash attempts spelling correction
shopt -s dotglob # include leading dot-files/dirs

##########################################
# Prompt                                 #
##########################################
# Source git-prompt for git-directory
# git-prompt.sh is located in /usr/share/git/... on every system with installed git
source /usr/share/git-core/contrib/completion/git-prompt.sh

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

# Configure git-prompt
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_DESCRIBE_STYLE="branch"
GIT_PS1_SHOWUPSTREAM="auto git"
GIT_PS1_SHOWCOLORHINTS=1
# Variables
# Reset PS1

set_prompt_start(){
  Last_Command=$?
  myPS1=""
  FancyX='\342\234\227'
  Checkmark='\342\234\223'

  if [[ $EUID == 0 ]]; then
    myPS1+="$txt_red["
  else
    myPS1+="$txt_blu["
  fi

  # If last Command failed print a fancyX
  if [[ $Last_Command != 0 ]]; then
    myPS1+="$txt_red$FancyX "
  fi

  # If root, just print the host in red. Otherwise, print the current user and host in blue.
  if [[ $EUID == 0 ]]; then
    myPS1+="$txt_red\\h "
  else
    myPS1+="$txt_blu\\u$txt_wht@$txt_blu\\h "
  fi

  # Print the working directory in white.
  myPS1+="$txt_wht\\W$col_off"
}

set_prompt_end(){
  # End Prompt with a red bracket and white prompt marker.
  if [[ $EUID == 0 ]]; then
    myPS1end="$txt_red] $txt_wht\\\$$col_off "
  else
    myPS1end="$txt_blu] $txt_wht\\\$$col_off "
  fi
}

PROMPT_COMMAND='set_prompt_start; set_prompt_end; __git_ps1 "$myPS1" "$myPS1end" "( %s)"'
