#!/bin/sh
PATH=/bin:/usr/bin:/sbin:/usr/sbin export PATH

#AD Service account info
binduser=bind_account
bindpass=l3opard

#Get the MAC address of the local computer
macid=`ifconfig en0 | grep 'ether' |cut -c 8-24`

#Querry the LDAP for the Computer name
rawcomputername=`dscl /LDAPv3/craxserve -list /Computers macAddress |grep -A 1 $macid`

#Format the computer name in such a way that it can be used to bind to AD
computername=`printf $rawcomputername`

#Bind to AD
dsconfigad -f -a $computername -domain janesville.k12.wi.us -u $binduser -p $bindpass -=CN=Computers,DC=janesville,DC=k12,DC=wi,DC=us -status

#Add search path the the local computer
dscl /Search -append / CSPSearchPath "/Active Directory/All Domains"

#Restart Directory Service
killall DirectoryService

# Disable autologin
defaults delete /Library/Preferences/com.apple.loginwindow autoLoginUser
srm -f /etc/kcpassword

# Kill loginwindow to return to the login screen
killall loginwindow

# Destroy this script!
rm -r /Users/admin/Library/Preferences/com.apple.loginitems.plist
srm "$0"

exit 0