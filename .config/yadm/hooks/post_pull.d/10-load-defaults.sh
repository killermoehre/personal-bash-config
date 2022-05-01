#!/bin/bash

declare _plist=""
find "$HOME/Library/Preferences" -name '*.xml' -print | while read -r _plist; do
    _domain_name="${_plist%.plist.xml}"
    _domain_name="${_domain_name##*/}"
    printf "Importing %s into %s\n" "$_plist" "$_domain_name"
    defaults import "$_domain_name" "$_plist"
done
