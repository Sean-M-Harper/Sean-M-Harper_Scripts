dscl . -delete /Users/
dscl . list /Users | grep -v "_"

#!/bin/bash

UserList=`/bin/ls /Users | /usr/bin/grep -v "Shared"`

for u in $UserList ; do

if [[ `/usr/bin/dscl . read /Groups/admin GroupMembership | /usr/bin/grep $u -c` == 1 ]]

then /bin/echo "Admin account detected skipping..."

else /usr/bin/dscl . delete /Users/$u && /bin/rm -rf /Users/$u

fi

done