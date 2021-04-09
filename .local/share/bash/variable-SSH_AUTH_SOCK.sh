#!/hint/bash
SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
declare -x SSH_AUTH_SOCK
launchctl setenv SSH_AUTH_SOCK "$SSH_AUTH_SOCK"
