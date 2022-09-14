#!/bin/bash

/Applications/Privileges.app/Contents/Resources/PrivilegesCLI --add
sudo pkill AnyConnect || true
gpgconf --launch gpg-agent
scutil --nc start "SAP Global"
