#!/bin/sh
# Allows all users of the system to add printers.
#
# Installation of printer drivers still requires administrative privileges.

dseditgroup -o edit -n /Local/Default -a everyone -t group -T group _lpadmin