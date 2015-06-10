#Brian D. West, Student Login Script School District of Janesville, 2010
#Modified by Sean M. Harper 2012
#!/bin/sh
PATH=/bin:/usr/bin:/sbin:/usr/sbin export PATH


#Global Varibles
user=`whoami`

#Functions

school()
{

mkdir /Volumes/$user
mkdir /Volumes/internet
mkdir /Volumes/Shared

`mount -o nobrowse -t smbfs //$user@$esc-psdc1/macfix$ /Volumes/internet`
`mount -t smbfs //$user@$1-staff1/StudentFiles/$user /Volumes/$user`
`mount -t smbfs //$user@$1-staff1/StudentFiles/_Shared /Volumes/Shared`
}

high_school()
{


mkdir /Volumes/$user
mkdir /Volumes/internet
mkdir /Volumes/Shared

`mount -o nobrowse -t smbfs //$user@$1-admin1/macfix$ /Volumes/internet`
`mount -t smbfs //$user@$1-staff2/StudentFiles/$user /Volumes/$user`
`mount -t smbfs //$user@$1-staff2/StudentFiles/_Shared /Volumes/Shared`
}

ESC()
{

mkdir /Volumes/internet

`mount -o nobrowse -t smbfs //$user@esc-psdc1/macfix$ /Volumes/internet`
}

#Main Program

#pulls the second octet for location
network=`ifconfig | grep "inet " | grep -v 127.0.0.1 |cut -c 10-11`

case "$network" in
1.) ESC ;;
10) high_school "cra" ;;
11) high_school "par" ;;
20) school "edi" ;;
21) school "fra" ;;
22) school "mar" ;;
30) school "ada" ;;
31) school "har" ;;
32) school "jac" ;;
33) school "jef" ;;
34) school "ken" ;;
35) school "lin" ;;
36) school "mad" ;;
37) school "mon" ;;
38) school "roo" ;;
39) school "van" ;;
40) school "was" ;;
41) school "wil" ;;
50) school "roc" ;;
51) school "tag" ;;
*) echo Not at a district site, call 608-743-5004.
esac

exit 0