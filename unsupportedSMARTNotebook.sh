#!/bin/bash

JH=/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper
notebook=`defaults read /Applications/SMART\ Technologies/Notebook.app//Contents/Info | awk '/CFBundleVersion/ {print}' | cut -f2 -d = | tr -d \'\"\;`


"$JH" -windowType utility -title "Unsupported Version" -heading "Unsupported version of SMART Notebook ($notebook)" -icon /Volumes/CasperShare/icons/sdj-logo.png  -description "Please note that you are currently running an unsupported version of SMART Notebook. \
  The School District of Janesville provides all the necessary installation materials required for SMART Notebook from within the Self Service app (/Applications/Self Service)." -button1 "Close"
