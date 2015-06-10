#!/bin/bash

WHOAMI=$(ls -l /dev/console | awk '{ print $3 }')
GETHOMEDIR="$(dscl /Active\ Directory/JANESVILLE/All\ Domains -read /Users/$WHOAMI HomeDirectory | awk ' {gsub("<","  "); print $3 } ' | cut -c 5- )"

	osascript -e 'mount volume "'$GETHOMEDIR'" '
