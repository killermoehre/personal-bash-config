#!/usr/bin/env bash
alias nova='nova --os-password "$(security find-generic-password -a $USER -s "Enterprise Connect" -w)"'