#!/bin/bash

for dir in /Users/*; do
    if [[ -e "${dir}/Library/Application\ Support/Firefox/Profiles/profiles.ini" ]]; then
        rm -R "${dir}/Library/Application\ Support/Firefox/"
        chown -R `id -un`:`id -gn` ~
        
    fi
done