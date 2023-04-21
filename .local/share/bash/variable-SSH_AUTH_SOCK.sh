#!/hint/bash
if hash launchctl &> /dev/null; then
    SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    launchctl setenv SSH_AUTH_SOCK "$SSH_AUTH_SOCK"
fi
if hash systemctl &> /dev/null; then
    SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
    systemctl --user set-environment "SSH_AUTH_SOCK=$SSH_AUTH_SOCK"
fi
declare -x SSH_AUTH_SOCK
