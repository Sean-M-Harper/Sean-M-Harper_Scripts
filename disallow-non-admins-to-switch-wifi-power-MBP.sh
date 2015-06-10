#!/bin/sh

# Makes setting to require admin privileges to turn Wi-Fi on or off.
#
# Requires Wi-Fi interface name to be "en1". This is typically the case for
# anything except MacBook Airs.

PREFS="/Library/Preferences/SystemConfiguration/preferences.plist"

CURRENT_SET=$(/usr/libexec/PlistBuddy -c "Print:CurrentSet" "$PREFS" \
| sed 's/\/Sets\///g')

/usr/libexec/PlistBuddy -c \
"Set:Sets:$CURRENT_SET:Network:Interface:en1:AirPort:RequireAdminPowerToggle \
  true" "$PREFS"
