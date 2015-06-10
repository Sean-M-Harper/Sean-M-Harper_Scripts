#!/bin/bash

# icloudbegone.sh by Jay Barnes
# This script disables the AppleID / iCloud popup that users are presented when logging in for the first time
# It must be run as root (not just administrator)

defaults write /System/Library/User\ Template/Non_localized/Library/Preferences/com.apple.SetupAssistant DidSeeCloudSetup -bool TRUE

defaults write /System/Library/User\ Template/Non_localized/Library/Preferences/com.apple.SetupAssistant LastSeenCloudProductVersion -string ’10.8.4′