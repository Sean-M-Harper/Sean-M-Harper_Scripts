#!/bin/sh

# delete needed files

# rm -rf /Applications/Hotspot\ Shield.app

for USER_HOME in /Users/*
  do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ]; then
       # Removing cache files from users' ~/Library/Application Support/Firefox folder
       if [ -d "${USER_HOME}"/Library/Application\ Support/Firefox/ ]; then
	rm -rf "${USER_HOME}"/Library/Application Support/Firefox/profiles.ini
       fi
##       # Removing preference file from users' ~/Library/Preferences	
##       if [ -f "${USER_HOME}"/Library/Preferences/com.anchorfree.Hotspot_Shield.plist ]; then
##	rm -rf "${USER_HOME}"/Library/Preferences/com.anchorfree.Hotspot_Shield.plist
##      fi
##       # Removing Hotsport Shield directory from users' ~/Library/Application Support
##       if [ -d "${USER_HOME}"/Library/Application\ Support/Hotsport\ Shield ]; then
##	rm -rf "${USER_HOME}"/Library/Application\ Support/Hotsport\ Shield
##       fi
    fi
done