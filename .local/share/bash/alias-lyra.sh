#!/bin/bash
if hash lyra &> /dev/null; then
    alias lyra='OS_PASSWORD="$(security find-generic-password -s com.jamfsoftware.SelfService.credentials -w )" lyra'
fi
