#!/bin/bash

en0=`ipconfig getifaddr en0 2>&1`

en1=`ipconfig getifaddr en1 2>&1`

machine_name=`scutil --get ComputerName 2>&1`


if [ "$en0" = "get if addr en0 failed, (os/kern) failure" ]; then

en0="unavailable"

fi


if [ "$en1" = "get if addr en1 failed, (os/kern) failure" ]; then

en1="unavailable"

fi


/usr/bin/osascript << EOF

tell application "Finder"

activate

display dialog "Your Machine Name: $machine_name" & return & "Wired IP Address: $en0" & return & "Wireless IP Address:
$en1" buttons {"OK"} with icon caution

end tell

EOF


exit 0