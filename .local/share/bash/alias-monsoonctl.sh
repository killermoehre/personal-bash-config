#!/usr/bin/env bash
alias monsoonctl='monsoonctl --github-token "$(security find-generic-password -a $USER -s "token:github.wdf.sap.corp:monsoonctl" -w)"'
