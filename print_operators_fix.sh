#!/bin/sh
# This script is designed to allow ALL users on a machine to modify print
# settings as general members of the PRINT OPERATORS group.
# In general, this allows users to pause and resume printers without issue.

# Created 11/19/14 by Sean Harper

/usr/sbin/dseditgroup -o edit -n /Local/Default -a everyone -t group lpadmin
exit 0
