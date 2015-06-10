#!/bin/sh

# Jason Bush 3/12/2014

# This script downloads and installs the latest Google voice and video call plug-in


# Change working directory to /tmp

cd /tmp

	# Download the latest Google voice and video call plug-in software disk image

	/usr/bin/curl -O https://dl.google.com/googletalk/googletalkplugin/GoogleVoiceAndVideoSetup.dmg

	# Mount the GoogleVoiceAndVideoSetup.dmg disk image in /Volumes

	/usr/bin/hdiutil attach GoogleVoiceAndVideoSetup.dmg -nobrowse -noverify -noautoopen

	# Install Google voice and video call plug-in from the installer package inside

	/usr/sbin/installer -dumplog -verbose -pkg /Volumes/GoogleVoiceAndVideoAccelSetup*/Google\ Voice\ and\ Video.pkg -target "/"

	# Clean-up
 
	# Unmount the GoogleVoiceAndVideoSetup.dmg disk image from /Volumes

	/usr/bin/hdiutil eject -force /Volumes/GoogleVoiceAndVideo*

	# Remove the GoogleVoiceAndVideoSetup.dmg disk image from /tmp

	/bin/rm -rf /tmp/GoogleVoiceAndVideoSetup.dmg

exit 0