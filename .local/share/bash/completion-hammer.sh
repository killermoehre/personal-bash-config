_hammer_completion() {
    local IFS=$'\t'
    COMPREPLY=( $( env COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   _HAMMER_COMPLETE=complete-bash $1 ) )
    return 0
}

complete -F _hammer_completion -o default hammer
