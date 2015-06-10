#!/bin/bash

for dir in /Users/*; do
    if [[ -e "${dir}/Library/Application Support/Google/Chrome" ]]; then
        rm -rf "${dir}/Library/Application Support/Google/Chrome"
    fi
done