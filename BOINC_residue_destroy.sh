#Written by Sean Harper on 02/05/13
#This script is used to destroy all remaining info left behind by the BOINC program

#!/bin/bash

rm -R /Library/Application\ Support/BOINC\ Data
rm /Users/admin/Library/Preferences/BOINC\ Manager\ Preferences
rm /Users/evan/Library/Preferences/BOINC\ Manager\ Preferences