#!/bin/bash
ME=`who | awk '{print $1}' | sort -u`

#CD=`/Applications/Utilities/CocoaDialog.app/Contents/MacOS/CocoaDialog  secure-standard-inputbox --title "Please input your password" | sed 1d`
MACFIX=smb://par-it-01/macfix$

osascript -e 'mount volume "'$MACFIX'" '

#cp -r /Volumes/CasperShare/Scripts/cocoaDialog.app /Applications/Utilities/ 

#if [[ ! -d $LOCAL_MOUNT ]]; then
	#mkdir $LOCAL_MOUNT 
	#$MOUNT

#else
	
#	$MOUNT

#fi

	
	



