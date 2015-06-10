#!/bin/bash

#Disables "Create Mobile Account at Login" found in Directory Services
dsconfigad -mobile enable  #Enable Mobile Accounts
dsconfigad -mobileconfirm disable #Disable confirmation of mobile account
