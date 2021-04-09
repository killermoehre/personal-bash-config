#!/hint/bash
SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
declare -x SSH_AUTH_SOCK
if hash launchctl &> /dev/null; then
    launchctl setenv SSH_AUTH_SOCK "$SSH_AUTH_SOCK"
fi
if hash systemctl &> /dev/null; then
    systemctl --user set-environment "SSH_AUTH_SOCK=$SSH_AUTH_SOCK"
fi
