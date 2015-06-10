#Global Varibles
user=`whoami`

#Functions

school()
{

mkdir /Volumes/$user
mkdir /Volumes/StudentFiles
mkdir /Volumes/Users
mkdir /Volumes/"Staff $user"
mkdir /Volumes/Shared

mkdir /Volumes/internet2
mkdir /Volumes/internet3
mkdir /Volumes/internet4
mkdir /Volumes/internet5


`mount -o nobrowse -t smbfs //$user@cra-it-01/macfix$ /Volumes/internet2`
`mount -o nobrowse -t smbfs //$user@par-it-01/macfix$ /Volumes/internet3`
`mount -o nobrowse -t smbfs //$user@esc-mstrdc/macfix$ /Volumes/internet4`
`mount -o nobrowse -t smbfs //$user@sdj-masterdc/macfix$ /Volumes/internet5`

`mount -t smbfs //$user@$1-staff1/StudentFiles/$user /Volumes/$user`
`mount -t smbfs //$user@$1-staff1/StudentFiles /Volumes/StudentFiles`
`mount -t smbfs //$user@$1-staff1/users /Volumes/Users`
`mount -t smbfs //$user@$1-staff1/users/$user /Volumes/"Staff $user"`
`mount -t smbfs //$user@$1-staff1/StudentFiles/_Shared /Volumes/Shared`
}

high_school()
{

mkdir /Volumes/userfiles
mkdir /Volumes/StudentFiles
mkdir /Volumes/Users
mkdir /Volumes/$user
mkdir /Volumes/collab
mkdir /Volumes/teacherfiles


mkdir /Volumes/internet2
mkdir /Volumes/internet3
mkdir /Volumes/internet4
mkdir /Volumes/internet5


`mount -o nobrowse -t smbfs //$user@cra-it-01/macfix$ /Volumes/internet2`
`mount -o nobrowse -t smbfs //$user@par-it-01/macfix$ /Volumes/internet3`
`mount -o nobrowse -t smbfs //$user@esc-mstrdc/macfix$ /Volumes/internet4`
`mount -o nobrowse -t smbfs //$user@sdj-masterdc/macfix$ /Volumes/internet5`

`mount -t smbfs //$user@$1/StudentFiles /Volumes/StudentFiles`
`mount -t smbfs //$user@cra-staff2/users /Volumes/userfiles`
`mount -t smbfs //$user@cra-staff2/users/$user /Volumes/$user`
`mount -t smbfs //$user@$1/StudentCollab /Volumes/collab`
`mount -t smbfs //$user@$1/StudentResources /Volumes/teacherfiles`

}

ESC()
{
mkdir /Volumes/$user

mkdir /Volumes/internet
mkdir /Volumes/internet2
mkdir /Volumes/internet3
mkdir /Volumes/internet4
mkdir /Volumes/internet5

`mount -o nobrowse -t smbfs //$user@esc-psdc1/macfix$ /Volumes/internet`
`mount -o nobrowse -t smbfs //$user@cra-it-01/macfix$ /Volumes/internet2`
`mount -o nobrowse -t smbfs //$user@par-it-01/macfix$ /Volumes/internet3`
`mount -o nobrowse -t smbfs //$user@esc-mstrdc/macfix$ /Volumes/internet4`
`mount -o nobrowse -t smbfs //$user@sdj-masterdc/macfix$ /Volumes/internet5`


`mount -t smbfs //$user@esc-admin2/users /Volumes/Users`
}

#Main Program

#pulls the second octet for location
network=`ifconfig | grep "inet " | grep -v 127.0.0.1 |cut -c 10-11`

case "$network" in
1.) ESC ;;
10) high_school "craig" ;;
11) high_school "parker" ;;
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