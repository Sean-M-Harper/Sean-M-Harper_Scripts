# Fixes (or restarts) ARD and Screen Sharing for OS X clients.
# Written by Sean Harper on 01/16/13.
# "sudo" excluded from each line due to the fact the Casper runs all scripts as root.

#!/bin/sh
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -off -restart -agent -privs -all -allowAccessFor -allUsers