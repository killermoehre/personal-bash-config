#!/usr/bin/env bash

if test -d "$HOME/development/ccee-secrets"; then
    git -C "$HOME/development/ccee-secrets" pull
else
    git clone git@github.wdf.sap.corp:cc/secrets.git "$HOME/development/ccee-secrets"
fi
if test -d "$HOME/development/chrome-extensions"; then
    git -C "$HOME/development/chrome-extensions" pull
else
    git clone https://github.tools.sap/b1-managed-service-ccee/chrome-extensions.git "$HOME/development/chrome-extensions"
fi
