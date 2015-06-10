#!/bin/bash
#Disables the PreLogin Check Issued by Mavericks  (Updating Managed Preferences window....)

defaults write /Library/Preferences/com.apple.mdmclient BypassPreLoginCheck -bool YES