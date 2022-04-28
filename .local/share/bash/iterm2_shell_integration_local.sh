#!/usr/local/bin/bash

function convert_landscape_into_emoji() {
    IFS='-' read -r -a landscape <<<"$1"
    if ((${#landscape[@]} == 3)); then
        local -r region="${landscape[0]}"
        local -r country="${landscape[1]}"
        local -r -i dc="${landscape[2]}"
    elif ((${#landscape[@]} == 4)); then
        local -r cluster="${landscape[0]}"
        local -r region="${landscape[1]}"
        local -r country="${landscape[2]}"
        local -r -i dc="${landscape[3]}"
        case "$cluster" in
        a) cluster_icon='' ;;   # unknown
        c) cluster_icon='≥' ;;   # web console
        i) cluster_icon='☁️' ;; # internet facing
        k) cluster_icon='🎮' ;;  # controller
        s) cluster_icon='⚖️' ;; # scaleout
        v) cluster_icon='𝒱🎮' ;; # virtual controller
        esac
    else
        printf '%s' "$1"
        return 0
    fi
    case "$region" in
    ap) region_icon='🌏' ;;
    eu) region_icon='🌍' ;;
    la) region_icon='🌎' ;;
    na) region_icon='🌎' ;;
    qa) region_icon='🚧' ;;
    esac
    declare country_icon=''
    printf -v unicode_start '%d' "'🇦"
    printf -v ascii_start '%d' "'a"
    for ((letter = 0; letter < ${#country}; letter++)); do
        printf -v char_number '%d' "'${country:$letter:1}"
        printf -v codepoint '%x' "$((unicode_start + char_number - ascii_start))"
        country_icon+="$(printf '%b' "\\U$codepoint")"
    done
    if test -v cluster; then
        printf '%s' "$cluster_icon"
    fi
    printf '%s%s%i⃣️' "$region_icon" "$country_icon" "$dc"
}

function iterm2_print_user_vars() {
    iterm2_set_user_var os_region "${OS_REGION_NAME:+$(convert_landscape_into_emoji "$OS_REGION_NAME")}"
    iterm2_set_user_var os_domain "${OS_PROJECT_DOMAIN_NAME:+☀️ $OS_PROJECT_DOMAIN_NAME}"
    iterm2_set_user_var os_project "${OS_PROJECT_NAME:+☁️ $OS_PROJECT_NAME}"
    iterm2_set_user_var kube_context "${KUBECTL_CONTEXT:+☸️$(convert_landscape_into_emoji "$KUBECTL_CONTEXT")}"
    iterm2_set_user_var kube_namespace "$KUBECTL_NAMESPACE"
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
    iterm2_set_user_var git_branch "${git_branch_status[branch.head]:+⌥ ${git_branch_status[branch.head]}${git_branch_status[branch.upstream]:+ → ${git_branch_status[branch.upstream]}}}"
    iterm2_set_user_var git_ahead "${git_ahead:+↑ $git_ahead}"
    iterm2_set_user_var git_behind "${git_behind:+↓ $git_behind}"
}
export iterm2_hostname="$HOSTNAME"
