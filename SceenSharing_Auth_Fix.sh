#Written by Sean Harper on 2/18/2013
#Allows all users to be able to access a machine via screen-sharing, needed for Casper Screen Share
#Must be run as root, or with sudo

/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -off -restart -agent -privs -all -allowAccessFor -allUsers