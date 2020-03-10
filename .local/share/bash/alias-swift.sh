#!/bash
alias swift='swift --os-password "$(security find-generic-password -s Exchange -w)"'
