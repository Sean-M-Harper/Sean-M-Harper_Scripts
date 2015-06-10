
#!/bin/bash

#Default Finder Prefs - PLIST configuration
#As the title suggests, this sets the SDJ default Finder Prefs (ShowExternalServers and ShowExternalDrives)
# April 2013 -- School District of Janesville - Brent Williams

function replaceSkel () 
{

	cp /Volumes/CasperShare/Scripts/com.apple.finder.plist /System/Library/User\ Template/English.lproj/Library/Preferences/

}


function replaceLocal ()
{


for u in `dscl . -list /Users`
	do
	
	cp /Volumes/CasperShare/Scripts/com.apple.finder.plist /Users/$u/Library/Preferences/
	chown $u /Users/$u/Library/Preferences/com.apple.finder.plist
done
		
}

replaceSkel

replaceLocal

killall Finder

exit 0
