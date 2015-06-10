#!/bin/bash
ADPASS=*******
ADMINPASS=*******
HOSTNAME=$(scutil --get LocalHostName)
JH=/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper
#serialNumber=$(system_profiler | grep "Serial Number (system)" | cut -d : -f2)

#Preps DirectoryService.plist to enable Active Directory binding

function bindToActiveDirectory()
{
	while [[ -z "$dialog" ]];
			do 
defaults write /Library/Preferences/DirectoryService/DirectoryService "Active Directory" Active 2&>1
dialog=$(osascript -e 'display dialog "Enter a Machine Name" default Answer ""
			set theAnswer to (text returned of result)')

if [[ $? -eq 1 ]]; then #If "cancel" is selected, close script.
		exit 1
fi

	if [[ -z "$dialog" ]]; then #If "hostname (theAnswer)" is zero-length (blank), do the following...
		buttonPress=$("$JH" -windowType utility -description "Hostname is blank. Please try again..." -button1 "Cancel" -button2 "Retry")
		$buttonPress
			if [[ "$buttonPress" -eq 2 ]]; then
				bindToActiveDirectory	#Re-loop through script if hostname is still blank
			else [[ "$buttonPress" -eq 0 ]] #Exit script if user clicks "Cancel"
				exit 1
			fi
				if [[ $? -eq 130 ]]; then
					killall jamfHelper
					rejoin=$("$JH" -windowType utility -description "Machine Already Bound to Active Directory. Please check record before proceeding." -button1 "Close" -button2 "Unbind")
				else
					echo "Test"
				fi
else
	"$JH" -windowType fs -description "Binding "$dialog" to Active Directory... " & 
	dsconfigad -a "$dialog" -domain janesville.k12.wi.us -u bind_account -p $ADPASS -lu cadmin -lp cadmin 
		
		if [[ $? -eq 78 ]]; then
		$rejoin
			if [[ "$rejoin" -eq 2 ]]; then
				dsconfigad -force -remove -u bind_account -p $ADMINPASS
				dialog=""
				bindToActiveDirectory

			else
				[[ "$rejoin" -eq 0 ]]
					exit 1
			fi
			dsconfigad -mobile enable	
			dsconfigad -mobileconfirm disable
			defaults read /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool true
			sleep 5
			killall jamfHelper 
		

		fi
	fi

	function enableRoot()
	{
	       
			
	if [[ $? -eq 0 ]]; then
		 "$JH" -windowType fs -description "Enabling Root User..." &
			dsenableroot -u admin -p $ADMINPASS -r $ADMINPASS 2&>1
			killall jamfHelper
				
			if [[ $? -eq 0 ]]; then
				"$JH" -windowType utility -description "Initial Setup Complete" -button1 "Close" &
				sleep 5
				exit 1

			else 
				"$JH" -windowType utility -description "Root User NOT enabled" -button1 "Close"  &
				sleep 5
				exit 1
			fi
		else 
			exit 1

			fi

	}

	enableRoot


done	

}

	bindToActiveDirectory
	
	
	



	



