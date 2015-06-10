#Created by Sean Harper on 2/4/13
#Should completely remove old MCX settings from a machine

#!/bin/bash

sudo rm -R /Library/Preferences/Managed\ Preferences/*
sudo dscl . -delete /Computers
dscl . -list Computers | grep -v "^localhost$" | while read computer_name ; do sudo dscl . -delete Computers/"$computer_name" ; done