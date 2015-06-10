#!/bin/bash

###########################################################
# Owner:School District of Janesville, WI
# Date: 1/20/15
# Author: Brent Williams
# Purpose: To connect the Adminstrators Handbook
#          and display a message of where it could be found.
############################################################

WHOAMI="$(ls -l /dev/console | awk '{ print $3 }')"
osascript -e 'mount volume "smb://'$WHOAMI'@esc-admin9/AdministratorsHandbook"'


open /Volumes/AdministratorsHandbook/
