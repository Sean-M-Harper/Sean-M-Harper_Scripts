#!/bin/bash
################################################
#	School District of Janesville 
#				Technology Department
#		
#	Author: Brent Williams
#	Date: 4/01/14
#	Purpose: Template for automating installation of software that happens to have frequent update cycles.
################################################

APP="Firefox"
APP_LOC="https://download-installer.cdn.mozilla.net/pub/firefox/releases/latest/mac/en-US/"


#STEP 1: DOWNLOAD Mozilla Firefox
if [[ ! -d $APP ]]; then
		mkdir /tmp/$APP
		cd /tmp/$APP
	else
		cd /tmp/$APP
fi


for file in $(curl -s $APP_LOC |
                  		grep href |
         					sed 's/.*href="//' |
             		 			sed 's/".*//' |
		  		 					sed 's/.*json//' |
       		 							grep '^[a-zA-Z].*' |
		  									awk END{print} ); do

    		echo "Downloading Newest $APP : $file..."
			curl -s -O $APP_LOC$file
done

#STEP 2: CONVERT TO .CDR; SKIP EULA AND INSTALL
echo "Copying $APP to Applications..."

if [[ -d /Applications/$APP.app ]]; then
		rm -r /Applications/$APP.app
		/usr/bin/hdiutil convert -quiet $file -format UDTO -o "${file%.*}" 
		/usr/bin/hdiutil mount -quiet -nobrowse -noverify -noautoopen  "${file%.*}".cdr 
	else
		/usr/bin/hdiutil convert -quiet $file -format UDTO -o "${file%.*}" 
       /usr/bin/hdiutil mount -quiet -nobrowse -noverify -noautoopen  "${file%.*}".cdr 

fi

sleep 5s
mv /Volumes/$APP/$APP.app /Applications/

umount /Volumes/$APP
rm -r /tmp/$APP













