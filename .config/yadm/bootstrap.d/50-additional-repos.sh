#!/usr/bin/env bash

if test -d "$HOME/development/secrets"; then
    git -C "$HOME/development/secrets" pull
else
    git clone git@github.wdf.sap.corp:cc/secrets.git "$HOME/development/secrets"
fi
if test -d "$HOME/development/chrome-extensions"; then
    git -C "$HOME/development/chrome-extensions" pull
else
    git clone https://github.tools.sap/b1-managed-service-ccee/chrome-extensions.git "$HOME/development/chrome-extensions"
fi
