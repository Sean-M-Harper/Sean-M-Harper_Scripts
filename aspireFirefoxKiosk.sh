#!/bin/bash
#####################
#Copies R-Kiosk-enabled Firefox Profile down for use in Aspire Testing.
#
#
#
######################
user=$(ls -l /dev/console | awk '{ print $3 }')
LIB="/Users/$user/Library/Application Support"
JH="/Library/Application Support/JAMF/"


function correctPerms()
{

	chown -R $user "$LIB"/Firefox
	chmod -R 755 "$LIB"/Firefox
	sleep 2
	sudo -u aspire /Applications/Firefox.app/Contents/MacOS/firefox -url http://tn.actaspire.org/

}



if [[ -d "$LIB"/Firefox/Profiles ]]; then
	rm -r "$LIB"/Firefox/Profiles/*
	sleep 3
	rsync -avz /Volumes/CasperShare/aspireTesting/Profiles "$LIB"/Firefox/
	rsync -avz /Volumes/CasperShare/aspireTesting/profiles.ini "$LIB"/Firefox/
	sleep 2

	correctPerms
	
	

else
	mkdir -p "$LIB"/Firefox/Profiles/
	sleep 3
	rsync -avz /Volumes/CasperShare/aspireTesting/Profiles  "$LIB"/Firefox/
	rsync -avz /Volumes/CasperShare/aspireTesting/profiles.ini "$LIB"/Firefox/
	sleep 2

	correctPerms
	
	
fi
