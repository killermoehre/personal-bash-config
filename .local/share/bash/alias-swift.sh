#!/usr/bin/env bash
alias swift='swift --os-password "$(security find-generic-password -a $USER -s "Enterprise Connect" -w)"'