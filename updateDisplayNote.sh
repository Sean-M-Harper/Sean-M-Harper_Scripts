#!/bin/bash
################################################
#	School District of Janesville 
#				Technology Department
#		
#	Author: Brent Williams
#	Date: 4/01/14
#	Purpose: Automatically Downloads the newest version of DisplayNote
#		and installs on the clients.
################################################

#STEP 1: DOWNLOAD DISPLAYNOTE
if [[ ! -d DisplayNote ]]; then
		mkdir /tmp/DisplayNote
		cd /tmp/DisplayNote
	else
		cd /tmp/DisplayNote
fi

site="http://displaynote.com/public/uploads/displaynote/macos/"

for file in $(curl -s $site |
                  		grep href |
         					sed 's/.*href="//' |
             		 			sed 's/".*//' |
		  		 					sed 's/.*json//' |
       		 							grep '^[a-zA-Z].*' |
		  									awk END{print} ); do

    		echo "Downloading Newest DisplayNote Version : $file..."
			curl -s -O $site$file
done

#STEP 2: CONVERT TO .CDR, SKIP EULA AND INSTALL
echo "Copying DisplayNote to Applications..."

if [[ -d /Applications/DisplayNote.app ]]; then
		rm -r /Applications/DisplayNote.app
		/usr/bin/hdiutil convert -quiet $file -format UDTO -o "${file%.*}"
		/usr/bin/hdiutil mount -quiet -nobrowse -noverify -noautoopen  "${file%.*}".cdr 
	else
		/usr/bin/hdiutil convert -quiet $file -format UDTO -o "${file%.*}"
       /usr/bin/hdiutil mount -quiet -nobrowse -noverify -noautoopen  "${file%.*}".cdr 

fi

sleep 5s
mv /Volumes/"${file%.*}"/DisplayNote.app /Applications/


umount /Volumes/"${file%.*}"
rm -r /tmp/DisplayNote









