#!/bin/sh
#Fixes Spotlight not working
#Sets all target machines to use time.apple.com as a time server, 
#as well as turning on network time.

systemsetup -setnetworktimeserver time.apple.com
systemsetup -setusingnetworktime on