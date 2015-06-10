#!/bin/bash

#Cocoa Dialog location
CD=/Volumes/CasperShare/Scripts/CocoaDialog.app/Contents/MacOS/CocoaDialog

# -e for "if" is a file (non-regular - e.g. .txt, etc.)

  if [[ -e /dev/cu.usbserial ]]; then

    open /Applications/Utilities/Terminal.app/Contents/MacOS/Terminal screen /dev/cu.usbserial

  else

    install=$("$CD" msgbox --title "Confirm Install" --text "In order to use the USB to Serial connection, your Mac requires a driver update... " --informative-text "A reboot will be required to finish installtion." --width 545 --height 120 --button1 "Install" --button2 "Cancel" --string-output)

      if [[ $install == "Install" ]]; then

       /usr/sbin/installer -pkg /Volumes/CasperShare/Packages/usb-to-serial-driver.pkg -target /

      else
        "$CD" msgbox --title "Cancel Install" --text "Installation Cancelled" --informative-text "User Initiated Cancellation of Package" --width 515 --height 120 --button1 "Close"
        exit 0


      fi

    rebootNow=$("$CD" msgbox --title "Reboot Required" --text "Driver Update Successful -- Reboot Required to finish installation." --informative-text "Press 'Confirm' to continue, otherwise Cancel." --width 515 --height 120 --button1 "Reboot" --button2 "Cancel" --string-output)
        if [[ $rebootNow == "Reboot" ]]; then
          /sbin/reboot

        else
          exit 0

        fi
  fi
  exit 0
