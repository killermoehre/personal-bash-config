#!/usr/bin/env bash
alias cinder='cinder --os-password "$(security find-generic-password -a $USER -s "Enterprise Connect" -w)"'