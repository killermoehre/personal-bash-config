#!/bin/bash
# vim: set tabstop=4 softtabstop=4 expandtab shiftwidth=4 smarttab:
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

function debug_echo() {
    if [[ "$DEBUG" ]]; then
        echo "$@"
    fi
}

declare -a source_files_dirs=('/etc/profile')
# on Arch Linux, /etc/profile actually sources /etc/profile.d
if [[ "$(uname -s)" != 'Linux' ]]; then
    source_files_dirs+=('/etc/profile.d')
fi
source_files_dirs+=('/usr/local/etc/profile.d')
source_files_dirs+=("$HOME/.local/share/bash")
declare -x BASH_COMPLETION_COMPAT_DIR='/usr/local/etc/bash_completion.d' # to be able to use /usr/local/etc/bash_completion.d
for source_file_dir in "${source_files_dirs[@]}"; do
    if test -f "$source_file_dir"; then
        debug_echo "Sourcing $source_file_dir"
        . "$source_file_dir"
    elif test -d "$source_file_dir"; then
        pushd "$source_file_dir" &>/dev/null || exit 1
        for file in *.sh; do
            debug_echo "Sourcing ${source_file_dir}/$file"
            . "$file"
        done
        popd &>/dev/null || exit 1
    fi
done
