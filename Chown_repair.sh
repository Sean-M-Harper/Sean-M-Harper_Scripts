#!/bin/bash

for dir in /Users/*; do
    if [[ -e "${dir}/Library/Application\ Support/" ]]; then
        chown -R `id -un`:`id -gn` ~
        
    fi
done