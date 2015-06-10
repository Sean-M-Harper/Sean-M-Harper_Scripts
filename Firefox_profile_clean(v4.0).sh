#!/bin/bash

for dir in /Users/*; do
    if [[ -e "${dir}/Library/Application Support/Firefox/profiles.ini" ]]; then
        rm "${dir}/Library/Application Support/Firefox/profiles.ini"
    fi
done