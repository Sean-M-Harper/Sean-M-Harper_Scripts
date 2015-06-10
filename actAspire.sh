#!/bin/bash

###############################
#
#   Date: 4/18/15
#
#   Author: Brent Williams
#   Purpose: Checks for the validity of correct Java version
#   and setups up Secure Browser for Aspire testing
#
###############################

CD=/Volumes/CasperShare/Scripts/cocoaDialog.app/Contents/MacOS/cocoaDialog
USER=`ls -l /dev/console | awk '{ print $3 }'`

osVersion=`sw_vers -productVersion`
javaHome="/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home/bin/java"
safariVers=$(defaults read /Applications/Safari.app/Contents/Info.plist | awk '/CFBundleShortVersionString/ { print } ' | cut -f2 -d = | tr -d \'\"\;)



function updateJavaViaJSS()

{
  dialog=$("$CD" msgbox --text "Updating Java" --informative-text "Please wait - ACT Aspire will load once the updated has completed.") &
  jamf policy -event actAspire -verbose

  sleep 5s
  killall "cocoaDialog"

  requirementCheck

}


function loadAspire()
{

  #Ensures Safari is not running prior to copying plist from network share.
  killall "Safari"

  #Displays message dialog to user
  dialog=$("$CD" msgbox --text "Preparing Test" --informative-text "Test will load momentarily...") &

  #Disables auto-update for Java
  defaults write /Library/Preferences/com.oracle.java.Java-Updater JavaAutoUpdateEnabled -bool false

  #Copies modified plist to currently logged in user's profile
  cp /Volumes/CasperShare/com.apple.Safari.plist /Users/$USER/Library/Preferences/

  #Changes ownership to current user (was copied as root)
  chown $USER /Users/$USER/Library/Preferences/com.apple.Safari.plist

  #Converts plist into acceptable format for Safari
  plutil -convert xml1 /Users/$USER/Library/Preferences/com.apple.Safari.plist

  #Pauses for 5 seconds
  sleep 5s

  #Reads plist and prepares for Safari (executes as current user)
  sudo -u $USER defaults read com.apple.Safari > /dev/null

  #Pauses for 3 seconds (enough time for plist to be read)
  sleep 3s

  #Closes background process from above message dialog
  killall "cocoaDialog"

  #Opens Safari to ACT Aspire Login Page
  open -a Safari http://tn.actaspire.org/client/index.html#login

}


function requirementCheck() #Checks for each main and sub version of Java and updates accordingly, if needed.
{
  mainVers=$("$javaHome" -version 2>&1 | awk '/java version/ { print $3 }' | tr -d \'\"\; | cut -b -3)
  subVers=$("$javaHome" -version 2>&1 | awk '/java version/ { print $3 }' | tr -d \'\"\; | cut -d "_" -f 2)

  #Checking whether Java is 1.7
  java7VersionCheck=`echo "$mainVers == 1.7" | bc`

  #CHecking whether Java is Update 75 or higher
  java7SubVersionCheck=`echo "$subVers >= 75" | bc`

  #Checking whether Java is 1.8
  java8VersionCheck=`echo "$mainVers == 1.8" | bc`

  #Checking whether Java is Update 20 or higher
  java8SubVersionCheck=`echo "$subVers >= 20" | bc`

#If Java 1.7 and Update 75 (or higher) are present, load Aspire function above.
if [[ $java7VersionCheck -eq 1 && $java7SubVersionCheck -eq 1 ]]; then

  loadAspire

elif
   [[ $java8VersionCheck -eq 1 && $java8SubVersionCheck -eq 1 ]]; then

  loadAspire

else
  dialog=$("$CD" msgbox --text "Java does not meet minimum requirements" --informative-text "You may select 'Update Now' to continue. Otherwise, click 'Close and Log Off' and move to another computer." --button1 "Update Now" --button2 "Close and Log Off")

    if [ "$dialog" -eq 1 ]; then

        updateJavaViaJSS
    else

      dialog=$("$CD" msgbox --text "Confirm Log Off" --informative-text "You are about to log off this computer. Are you sure?" --button1 "Cancel" --button2 "Confirm")

        if [ "$dialog" -eq 2 ]; then

      #Logs off user account
      killall loginwindow

        else
          exit 0
        fi


    fi
fi

}

requirementCheck
