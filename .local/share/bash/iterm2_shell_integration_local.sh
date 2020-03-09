#!/usr/local/bin/bash

function iterm2_print_user_vars() {
    IFS='-' read -r world_region country dc <<<"$OS_REGION_NAME"
    case "$world_region" in
    ap) WORLD_ICON='🌏' ;;
    eu) WORLD_ICON='🌍' ;;
    la) WORLD_ICON='🌎' ;;
    na) WORLD_ICON='🌎' ;;
    qa) WORLD_ICON='🚧' ;;
    esac
    declare COUNTRY_FLAG=''
    printf -v unicode_start '%d' "'🇦"
    printf -v ascii_start '%d' "'a"
    for ((letter = 0; letter < ${#country}; letter++)); do
        printf -v char_number '%d' "'${country:$letter:1}"
        printf -v codepoint '%x' "$((unicode_start + char_number - ascii_start))"
        COUNTRY_FLAG+="$(printf '%b' "\\U$codepoint")"
    done
    # after ${dc} there is a Variation Selector-16 and a Combining Enclosing Keycap, turning the number into a key
    iterm2_set_user_var os_region "${OS_REGION_NAME:+$WORLD_ICON$COUNTRY_FLAG${dc}️⃣}"
    iterm2_set_user_var os_domain "${OS_PROJECT_DOMAIN_NAME:+☀️ $OS_PROJECT_DOMAIN_NAME}"
    iterm2_set_user_var os_project "${OS_PROJECT_NAME:+☁️ $OS_PROJECT_NAME}"
    kube_context="$(kubectl config current-context 2>/dev/null)"
    iterm2_set_user_var kube_context "${kube_context:+☸️ $kube_context}"
    declare -A git_branch_status=(['branch.ab']='+0 -0')
    while read -r git_status_comment git_option git_argument; do
        if [[ "$git_status_comment" == '#' ]]; then
            git_branch_status["$git_option"]="$git_argument"
        fi
    done < <(git status --porcelain=v2 --branch 2>/dev/null)
    if test "${git_branch_status[branch.ab]}"; then
        IFS=' ' read -r git_ahead git_behind <<<"${git_branch_status[branch.ab]}"
        declare -i git_ahead="$git_ahead"
        declare -i git_behind="$((git_behind * -1))"
        ((git_ahead == 0)) && unset git_ahead
        ((git_behind == 0)) && unset git_behind
    fi
    iterm2_set_user_var git_branch "${git_branch_status[branch.head]:+⌥ ${git_branch_status[branch.head]}}"
    iterm2_set_user_var git_ahead "${git_ahead:+↑ $git_ahead}"
    iterm2_set_user_var git_behind "${git_behind:+↓ $git_behind}"
}
export iterm2_hostname="$HOSTNAME"
