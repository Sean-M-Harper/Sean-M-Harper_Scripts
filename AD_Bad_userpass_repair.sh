#!/bin/sh
#Written by Sean Harper on 11/26/2012
#Fixes machines that report a "bad user name and password" error when binding
#Run against machines not allowing 

-rdfv /Library/Preferences/DirectoryService
-rdfv /var/db/dslocal/nodes/Default/config
killall -USR1 DirectoryService