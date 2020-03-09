#!/bin/bash
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

function debug_echo() {
    if [[ "$DEBUG" ]]; then
        echo "$@"
    fi
}

declare -a source_files_dirs=('/etc/profile' '/usr/local/etc/profile.d' "$HOME/.local/share/bash")
declare -x -r BASH_COMPLETION_COMPAT_DIR='/usr/local/etc/bash_completion.d' # to be able to use /usr/local/etc/bash_completion.d
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
