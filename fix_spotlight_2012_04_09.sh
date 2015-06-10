#!/bin/sh
#Fixes Spotlight not working
#Run after Imaging
cd /
rm .metadata_never_index
mdutil -E -i on /
