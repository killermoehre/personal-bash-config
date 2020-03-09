#!/usr/bin/env bash
alias neutron='neutron --os-password "$(security find-generic-password -a $USER -s "Enterprise Connect" -w)"'