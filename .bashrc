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

for _path in "$HOME/.local/bin" /opt/homebrew/{opt/mysql-client/bin,bin,sbin} /data/data/com.termux/files/{usr/sbin,usr/bin,sbin,bin}; do
    test -d "$_path" && _paths+=("$_path")
done

# macos has some fancy ways of declaring new paths
if test -e /etc/paths; then
    while read -r _path; do
        test -d "$_path" && _paths+=("$_path")
    done < /etc/paths
fi
if test -d /etc/paths.d; then
    for _file in /etc/paths.d/*; do
        while read -r _path; do
            test -d "$_path" && _paths+=("$_path")
        done < "$_file"
    done
fi

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

case "$(/usr/bin/uname -s)" in
    # on macos, /etc/profile does weird $PATH stuff
    'Linux')
        source_files_dirs+=('/etc/profile')
        ;;
    # on Arch Linux, /etc/profile actually sources /etc/profile.d
    'Darwin')
        source_files_dirs+=('/etc/profile.d')
        ;;
esac

declare _dir=''
for _dir in /opt/homebrew/etc/profile.d /usr/local/etc/profile.d "$HOME/.local/share/bash"; do
    test -d "$_dir" && source_files_dirs+=( "$_dir" )
done
for _dir in /{opt/homebrew,usr/local}/etc/bash_completion.d; do
    if test -d "$_dir"; then
        declare -x BASH_COMPLETION_COMPAT_DIR="$_dir"
        break
    fi
done

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
