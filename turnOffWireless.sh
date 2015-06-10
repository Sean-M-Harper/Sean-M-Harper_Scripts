#!/bin/sh
networksetup -setairportpower airport off
/usr/libexec/airportd prefs RequireAdminPowerToggle=YES
exit 0
