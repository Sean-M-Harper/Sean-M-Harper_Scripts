#!/bin/bash

wifi=`networksetup -listallhardwareports | awk '/Hardware Port: Wi-Fi/,/Ethernet/' | awk 'NR==2' | cut -d " " -f 2`
ssid=`networksetup -getairportnetwork $wifi | cut -d " " -f 4`

case $ssid in
    RCK | RCK-Public)
        echo "Switching off UW-Rock County Wireless SSIDs..."
        networksetup -setairportpower $wifi off
        networksetup -removepreferredwirelessnetwork $wifi $ssid
        networksetup -setairportpower $wifi on
        osascript -e 'tell application "System Events" to display alert "You have connected to a non-approved wireless network. We are automatically connecting you back to SDJ-Secure"'
        ;;
esac
