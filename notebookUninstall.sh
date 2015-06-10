#!/bin/bash

CD=/Volumes/CasperShare/Scripts/CocoaDialog.app/Contents/MacOS/CocoaDialog
notebook=$(defaults read /Applications/SMART\ Technologies/Notebook.app/Contents/Info | awk '/CFBundleVersion/ {print}' | cut -f2 -d = | tr -d \'\"\;)


#Checks if SMART Notebook is installed.



function uninstallNotebook()
{
#Uninstall SMART Notebook
#Checks for running SMART Products and/or services
procID=$(ps -ef | awk '/SMART Technologies/ {print $2}' | sed '$d')

#Provides dialog box for end-user to confirm uninstall
prompt=$("$CD" msgbox --title "Confirm Uninstall" --text "You are about to remove SMART Notebook $notebook from your Mac." --informative-text "Press 'Confirm' to continue, otherwise Cancel." --icon-file ~/Desktop/notebook-trash.png --width 515 --height 120 --button1 "Confirm" --button2 "Cancel" --string-output)


    if [[ $prompt == "Confirm" ]] && [[ -d /Applications/SMART\ Technologies ]]; then
        echo "Killing SMART processes and applications..."
        for id in $procID

          do

            kill -9 $id

          done

          echo -n "SMART Processes Terminated"

          echo "Uninstalling SMART files..."
          rm -r "/Applications/SMART Technologies"
          rm -r "/Library/Application Support/SMART Technologies"
          rm -r /Library/Preferences/com.smarttech.settings.plist
          echo "Uninstallation Complete."

    else
          exit 0

  fi
}



if [[ -d /Applications/SMART\ Technologies ]];then

  uninstallNotebook

else
  exit 0

fi
