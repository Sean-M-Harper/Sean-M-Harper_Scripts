#!/bin/sh

# Makes setting to not require admin privileges to turn Wi-Fi on or off. This
# is the default behavior.
#
# Requires Wi-Fi interface name to be "en0". This is typically the case for
# MacBook Airs.

PREFS="/Library/Preferences/SystemConfiguration/preferences.plist"

CURRENT_SET=$(/usr/libexec/PlistBuddy -c "Print:CurrentSet" "$PREFS" \
| sed 's/\/Sets\///g')

/usr/libexec/PlistBuddy -c \
"Set:Sets:$CURRENT_SET:Network:Interface:en0:AirPort:RequireAdminPowerToggle \
  false" "$PREFS"
