sudo rm -R /Library/Managed\ Preferences/*
sudo rm -R /Library/Preferences/SystemConfiguration/com.apple.AutoWake.plist
sudo rm -R /Library/Preferences/SystemConfiguration/com.apple.Boot.plist
sudo rm -R /Library/Preferences/SystemConfiguration/com.apple.PowerManagement.plist
sudo dscl . -delete /Computers
dscl . -list Computers | grep -v "^localhost$" | while read computer_name ; do sudo dscl . -delete Computers/"$computer_name" ; done
sudo jamf manage
sudo jamf mcx