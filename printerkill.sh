#!/bin/bash

lpstat -p | awk '{print $2}' | while read printer
do
  echo "Clearing Queue for Printer:" $printer
  lprm - -P $printer
done