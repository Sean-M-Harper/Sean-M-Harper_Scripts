#!/bin/bash

LOCALHOST=`scutil --get LocalHostName`

echo “Correcting DNS…”

scutil --set HostName $LOCALHOST
