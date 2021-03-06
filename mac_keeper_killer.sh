#!/bin/bash
 
# This program will uninstall MacKeeper and JustCloud
# Authored by http://www.kitzy.org/blog/removing-mackeeper, edited by Sean Harper on 02/24/15
 
#################
### Variables ###
#################
 
# Items at the system level to be removed
systemItems=(
	/Applications/MacKeeper.app
	/Applications/JustCloud.app
	/Library/Preferences/.3FAD0F65-FC6E-4889-B975-B96CBF807B78
	/private/var/folders/mh/yprf0vxs3mx_n2lg3tjgqddm0000gn/T/MacKeeper*
	/private/tmp/MacKeeper*
)
 
# Items at the user level to be removed
userItems=(
	Library/Application\ Support/MacKeeper\ Helper
	Library/LaunchAgents/com.zeobit.MacKeeper.Helper.plist
	Library/LaunchAgents/com.jdibackup.JustCloud.autostart.plist
	Library/LaunchAgents/com.jdibackup.JustCloud.notify.plist
	Library/Logs/JustCloud
	Library/Logs/MacKeeper.log
	Library/Logs/MacKeeper.log.signed
	Library/Logs/SparkleUpdateLog.log
	Library/Preferences/.3246584E-0CF8-4153-835D-C7D952862F9D
	Library/Preferences/com.zeobit.MacKeeper.Helper.plist
	Library/Preferences/com.zeobit.MacKeeper.plist
	Library/Saved\ Application\ State/com.zeobit.MacKeeper.savedState
	Downloads/MacKeeper*
	Documents/MacKeeper*
)
 
#################
### Functions ###
#################
 
function deleteItems()
{
	declare -a toDelete=("${!1}")
 
	for item in "${toDelete[@]}"
		do
			if [[ ! -z "${2}" ]]
				then
					item=("${2}""${item}")
			fi
 
			echo "Looking for $item"
 
			if [ -e "${item}" ]
				then
					echo "Removing $item"
					rm -rf "${item}"
			fi
		done
}
 
####################
### Main Program ###
####################
 
# Delete system level items
deleteItems systemItems[@]
 
# Delete user level items
for dirs in /Users/*/
		do
			deleteItems userItems[@] "${dirs}"
		done
 
exit 0