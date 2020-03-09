_cld_completion() {
            local IFS=$'
'
            COMPREPLY=( $( env COMP_WORDS="${COMP_WORDS[*]}" \
                           COMP_CWORD=$COMP_CWORD \
                           _CCLOUD_MULTITOOL_COMPLETE=complete ccloud-multitool ) )
            return 0
        }

        _cld_completionetup() {
            local COMPLETION_OPTIONS=""
            local BASH_VERSION_ARR=(${BASH_VERSION//./ })
            # Only BASH version 4.4 and later have the nosort option.
            if [ ${BASH_VERSION_ARR[0]} -gt 4 ] || ([ ${BASH_VERSION_ARR[0]} -eq 4 ] && [ ${BASH_VERSION_ARR[1]} -ge 4 ]); then
                COMPLETION_OPTIONS="-o nosort"
            fi

            complete $COMPLETION_OPTIONS -F _cld_completion cld
        }

        _cld_completionetup;
