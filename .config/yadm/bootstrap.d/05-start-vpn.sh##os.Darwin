#!/bin/bash

if test -x /usr/bin/scutil; then
    /usr/sbin/scutil --nc start "SAP Global"
    until [[ "$(/usr/sbin/scutil --nc status "SAP Global" | head -1)" == "Connected" ]]; do
        echo "Connecting to SAP Global"
        sleep 1
    done
    echo "Connected to SAP Global"
fi
