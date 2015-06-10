#!/bin/bash

#################
#	Author: Brent Williams
#	Copies Agent Orange and Komika Title to /Library/Fonts for use with International Bridges Festitval Fonts
#	May 2014
#################

JH=/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper


cp /Volumes/CasperShare/fonts/*.ttf /Library/Fonts
sleep 5
"$JH" -windowType utility -title "International Bridges Festival Font(s) Install " -description "Fonts AGENT ORANGE and KOMIKA TITLE have been installed successfully! Please close any applications you have open (such as Microsoft Word) and reopen for the fonts to take affect." -button1 "Close" -icon /Volumes/CasperShare/fonts/IBF.jpg


 