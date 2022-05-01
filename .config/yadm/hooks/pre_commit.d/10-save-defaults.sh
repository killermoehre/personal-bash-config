#!/bin/bash

declare _plist=""
find "$HOME/Library/Preferences" -name '*.xml' -print | while read -r _plist; do
    _domain_name="${_plist%.plist.xml}"
    _domain_name="${_domain_name##*/}"
    printf "Exporting %s into %s\n" "$_plist" "$_domain_name"
    # to have nice xml files, the redirect via stdout is necessary. Else, binary files are written
    defaults export "$_domain_name" - > "$_plist"
done
