# Fixes (or restarts) ARD and Screen Sharing for OS X clients.
# Written by Sean Harper on 01/16/13.
# "sudo" excluded from each line due to the fact the Casper runs all scripts as root.

#!/bin/sh
defaults write /var/db/launchd.db/com.apple.launchd/overrides.plist com.apple.screensharing -dict Disabled -bool false
launchctl load /System/Library/LaunchDaemons/com.apple.screensharing.plist