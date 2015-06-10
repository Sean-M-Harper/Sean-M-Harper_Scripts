#!/bin/bash
################################################
#	School District of Janesville 
#				Technology Department
#		
#	Author: Brent Williams
#	Date: 4/01/14
#	Purpose: Template for automating installation of software that happens to have frequent update cycles.
################################################

APP="Adobe_Reader"
APP_LOC="ftp://ftp.adobe.com/pub/adobe/reader/mac"
PRIMARYVERSION=`curl -s $APP_LOC/ | awk '{ print $9 }' | sort -n | awk END{print}`   #Gets version  (e.g. 11.x)
SUBVERSION=`curl -s $APP_LOC/$PRIMARYVERSION/ | awk '{ print $9 }' | sort -n | awk END{print}` #Gets sub-version (e.g. 11.0.06)
NEWAPP=`curl -s $APP_LOC/$PRIMARYVERSION/$SUBVERSION/misc/ | awk ' /pkg/ { print $9 }' ` # Download newest .pkg file


#STEP 1: DOWNLOAD Adobe Reader
if [[ ! -d $APP ]]; then
		mkdir /tmp/$APP
		cd /tmp/$APP
	else
		cd /tmp/$APP
fi

    #echo "Downloading Newest $APP: $NEWAPP..."
	curl -s -O $APP_LOC/$PRIMARYVERSION/$SUBVERSION/misc/$NEWAPP

# INSTALL ADOBE UPDATE...
/usr/sbin/installer -pkg /tmp/$APP/$NEWAPP -target /

sleep 5s

rm -r /tmp/$APP












