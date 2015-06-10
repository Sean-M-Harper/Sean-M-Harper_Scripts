#!/bin/bash

USER=$(ls -l /dev/console | awk '{ print $3 }')
chown -R $USER /Users/$USER