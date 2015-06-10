#!/bin/bash
########################################
##The below configuration will allow for a staff member on Mac to submit prefilled and properly formatted "tickets (emails) to the SDJ HelpDesk which will allow for auto-assigned Kaseya ticket"
#
#	School District of Janesville, WI
#	Author: Brent Williams 
#	Date: 11-03-2013
#		
#	VERSION: v0.1
########################################



#Predefining a few variables so that Pashua will auto-populate username, email address, hostname, ip, etc.
DATE="$(date +%F)"
WHOAMI="$(who | awk '{ print $1 }' | sort -u)" #Grabs the locally logged in username
HOSTNAME="$(scutil --get ComputerName)"   #Grabs hostname (one that was set by System Preferences. If "hostname" was used, it may change based on DNS)
JH="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"
#HOSTNAME=`hostname`

PASHUA=/Applications/Pashua.app/Contents/MacOS/Pashua #The Pashua Application responsible for creating the GUI
TMP=/var/tmp

GETREALNAME="$(dscl /Search -read /Users/$WHOAMI RealName | awk '{print $1,$2}' | cut -d ":" -f2 | sort -u)"
REALNAME="$(echo $GETREALNAME)"
#REALNAME=`dscl . read /Users/$CurrentUser | grep RealName | awk '{ print $2 }'` >/dev/null && echo "$RealName"`` 
#REALNAME="Brent Williams"

#FUNCTIONS
function mailTicket () {
tail -n 1 /etc/postfix/main.cf | grep 10.5.10.137 > /dev/null

	#Set SMTP host for proper email settings via mail
	if [[ ! $? -eq 0 ]]; then
		echo "relayhost = 10.5.10.137" >> /etc/postfix/main.cf
		/usr/sbin/postfix stop
		/usr/sbin/postfix start
	else
		/usr/sbin/postfix stop
		/usr/sbin/postfix start
	fi

SUMMARY="$(cat $TMP/kaseyaFormatted.pashua | awk '/summary=/' | cut -d "=" -f2)"
cat $TMP/kaseyaFormatted.pashua | mail -s "$HOSTNAME: $SUMMARY" helpdesk@janesville.k12.wi.us -f $WHOAMI@janesville.k12.wi.us -F "$REALNAME" && rm $TMP/*.pashua
#cat $TMP/kaseyaFormatted.pashua | mail -s "$HOSTNAME: $SUMMARY" jake4509@gmail.com -f $WHOAMI@janesville.k12.wi.us && rm $TMP/*.pashua

#Display Messsage on clean exit (submission of ticket)

"$JH" -windowType utility -title "Thank You" -icon /Applications/Pashua.app/sdj-logo.png -description "$REALNAME, thank you for submitting a ticket to the Service Desk. You will receive an email shortly with more details about your submission. Your ticket has been delivered to your technician or Innovcation Specialists' phone. Thank you for using technology to advance learning in the classroom." -button1 "Close" 


}

#function autoChooselocation () {

	#GETIP="$(ipconfig getifaddr en0 | awk -F. '{ print $2 }')" #Prints 2nd octet in IP address; chooses building based on subnet

	#case $GETIP in
	#		"")
	#			chooselocation=`echo ""`;;
	#		 1)
	#			chooselocation="Educational Services Center (ESC)";;
	#		10)
	#			chooselocation="Craig HS";;
	#		11) 
	#			chooselocation="Parker HS";;
	#		20) 
	#			chooselocation="Edison MS";;
	#		21)
	##		22)
	#			chooselocation="Marshall MS";;
	#		30)
	#			chooselocation="Adams Elem";;
	#		31)
	#			chooselocation="Harrison Elem";;
	#		32)
	#			chooselocation="Jackson Elem";;
	#		33)
	#			chooselocation="Jefferson Elem";;
	#		34)
	#			chooselocation="Kennedy Elem";;
	#		35)
	##		36)
	#			chooselocation="Madison Elem";;
#
#			*)
#				chooselocation=`echo " "`;;

#	esac			


#location=`echo $chooselocation`


#}
#autoChooselocation

#Check if cancel button is pressed. if true, then don't mail the ticket; if false, mail ticket.
function checkForCancelThenMail () {

	CANCEL=`tail -n 1 $TMP/kaseyaFormatted.pashua | awk '/cancel=/ { print }' | cut -d "=" -f2`

		if [[ ! $CANCEL -eq 0 ]]; then
			rm $TMP/*.pashua && exit 0 
		else
			mailTicket && exit 0
		fi
}


function formatAndWriteOutput () {

echo $conf | tr ";" "\n" > $TMP/tempConfig.pashua

#$PASHUA $TMP/tempConfig.pashua > $TMP/results.pashua; sed 's/^/~/' $TMP/results.pashua > $TMP/kaseyaFormatted.pashua
$PASHUA $TMP/tempConfig.pashua > $TMP/results.pashua && sleep 30 &&  sed 's/^/~/' $TMP/results.pashua > $TMP/kaseyaFormatted.pashua


}

conf="

;
#logo.type = image;
#logo.label =;
#logo.path = logo.png;
#logo.maxwidth = ;
#logo.border = no;
#logo.maxheight = ;
#logo.x = 135;
#logo.y = 635;
;
#logofiller.type = text;
#logofiller.label =;
#logofiller.default =;
;
summary.type = textfield;
summary.label = Summary;
summary.default = ;
summary.width = 450;
;
*.title = Submit a Ticket;
;
cancel.type = cancelbutton;
cancel.label = Cancel;
;
;name.type = textfield;
;name.label = Name:;
;name.default = $REALNAME;
;name.width = 250;
;
;email.type = textfield;
;email.label = Email:;
;email.default = $WHOAMI@janesville.k12.wi.us;
;email.width = 250;
;
#Start location ;
location.type = popup;
location.label = location/Building;
#location.option = $location;
location.option = 'ESC';
location.option = 'Adams Elem';
location.option = 'Harrison Elem';
location.option = 'Jackson Elem';
location.option = 'Jefferson Elem';
location.option = 'Kennedy Elem';
location.option = 'Lincoln Elem';
location.option = 'Madison Elem';
location.option = 'Monroe Elem';
location.option = 'Roosevelt Elem';
location.option = 'Van Buren Elem';
location.option = 'Washington Elem';
location.option = 'Wilson Elem';
location.option = 'Franklin MS';
location.option = 'Edison MS';
location.option = 'Marshall MS';
location.option = 'Craig HS';
location.option = 'Parker HS';
location.option = 'JVA';
location.option = 'JAIS';
location.option = 'RRCS';
location.option = 'TAGOS';
location.option = 'TATE';
location.option = 'P4J Sites';
location.width = 150;
;
#End location;
;
room.type = textfield;
room.label = Room (e.g., 1421, LMC, Yearbook Lab);
room.default = ;
room.width = 95;

#info.type = text;
#info.label = Other Information that will be submitted with the ticket;
#info.text = Hostname: $HOSTNAME [return] Username: $WHOAMI [return] Date: $DATE;
#info.relx =40
#info.rely =40
;
phone.type = textfield;
phone.label = Phone #;
phone.default =;
phone.width = 95;
;
;
Priority.type = popup;
Priority.label = Priority;
;Priority.default = 'Normal';
;Priority.option = Low;
;Priority.option = 'Normal';
;Priority.option = 'High';
;Priority.option = 'Emergency';
Priority.width = 150;
;
;
;Category.type = popup;
;Category.label = Category (Only Apple submissions at this time.);
;Category.option = 'Mobile Computer/Device Problems||Apple MAC/iOS';
#Category.option = Mac;
#Category.option = MacBook (Air/Pro);
#Category.option = iPad;
;Category.width = 350;
;Category.tooltip = Please choose a category;
;
#d.type = date;
#d.label = Today's Date;
#d.default = ;
#d.time = 1;
;
submit.type = defaultbutton;
submit.label = Submit;
;
;description.type = textbox;
;description.label = Description;
;description.width = 450;
;description.height = 100;
;description.tooltip = Describe your problem here:;



"

formatAndWriteOutput
checkForCancelThenMail #Checks for cancel and either exits or mails ticket.

