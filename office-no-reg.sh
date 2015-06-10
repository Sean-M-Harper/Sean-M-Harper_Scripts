
#!/bin/bash

#Microsoft Office 2011 for Mac - PLIST fix.
#This script will copy the Microsoft Office 2011 .plist files into each new user's ~/Library/Preferences folder
# to combat the initial (and always annoying) Microsoft registration prompts. (via /System/Library/User Template)
# April 2013 -- School District of Janesville - Brent Williams

function replaceSkel () 
{

#kills all Microsoft Office processes that would affect the plist copy process
	killall "Microsoft Word"
	killall "Microsoft Excel"
	killall "Microsoft PowerPoint"
	
	cp /Volumes/CasperShare/Scripts/Office-plist/com.microsoft.* /System/Library/User\ Template/English.lproj/Library/Preferences/

}


function replaceLocal ()
{


for u in `dscl . -list /Users`
	do
	
	cp /Volumes/CasperShare/Scripts/Office-plist/com.microsoft.* /Users/$u/Library/Preferences/
	chown $u /Users/$u/Library/Preferences/com.microsoft.*
done
		
}

replaceSkel

replaceLocal

killall Finder

exit 0
