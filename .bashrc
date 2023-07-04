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

declare -a _paths=''

for _path in "/usr/bin" "$HOME/.local/bin"; do
    test -d "$_path" && _paths+=("$_path")
done

unset PATH
for _path in "${_paths[@]}"; do
    if test ! -v PATH; then
        declare PATH="$_path"
    elif test -z "$PATH"; then
        PATH="$_path"
    else
        PATH="$PATH:$_path"
    fi
done
export PATH

declare -a source_files_dirs=()
declare _dir=''
for _dir in "/etc/profile" "$HOME/.local/share/bash"; do
    test -d "$_dir" && source_files_dirs+=( "$_dir" )
done

for source_file_dir in "${source_files_dirs[@]}"; do
    if test -f "$source_file_dir"; then
        debug_echo "Sourcing $source_file_dir"
        # shellcheck source=/dev/null
        . "$source_file_dir"
    elif test -d "$source_file_dir"; then
        pushd "$source_file_dir" &>/dev/null || exit 1
        for file in *.sh; do
            debug_echo "Sourcing ${source_file_dir}/$file"
            # shellcheck source=/dev/null
            . "$file"
        done
        popd &>/dev/null || exit 1
    fi
done
