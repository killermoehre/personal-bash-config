#!/usr/bin/env bash
alias glance='glance --os-password "$(security find-generic-password -a $USER -s "Enterprise Connect" -w)"'