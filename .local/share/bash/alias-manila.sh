#!/usr/bin/env bash
alias manila='manila --os-password "$(security find-generic-password -a $USER -s "Enterprise Connect" -w)"'