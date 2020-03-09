#!/bash
alias limesctl='limesctl --os-password "$(security find-generic-password -a $USER -s "Enterprise Connect" -w)"'
