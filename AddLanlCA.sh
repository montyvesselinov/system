#!/bin/sh
# One liner script to add the LANL CA to user Certificate db

#get which linux distro we're on and set to dist
certutil=/usr/bin/certutil
if [ -f /usr/bin/lsb_release ]
then
	dist=$(/usr/bin/lsb_release -dr)
elif [ -f /etc/system-release ]
then
	IFS=$'\n' read -d '' -r -a lines < /etc/system-release
	dist=${lines[0]}
elif [ -f /etc/os-release ]
then
	IFS=$'\n' read -d '' -r -a lines < /etc/os-release
	for i in "${lines[@]}"
	do
		if [ "$i" = "^NAME" ]
		then
		dist=$i
		fi
	done
fi
mkdir=""

#converts to lowercase
dist="$(echo $dist | tr '[:upper:]' '[:lower:]')"

#fedora requires .pem file
if [ "$dist" = "fedora" ]
then
	cert=/usr/share/LANL-WINOLTcert/resources/LANLWINOLT.pem
else
	cert=/usr/share/LANL-WINOLTcert/resources/LANLWINOLT.crt
fi

#check if certs exist
if ! [ -f $cert ]
then
	exit 1
fi
#determine location of mkdir binary and create nssdb database
if ! [ -d $HOME/.pki/nssdb ]
then
	if [ $dist = .*red\ hat.*release\ 6.* ] || [ $dist = debian ] || [ $dist = ubuntu ]
	then
		/bin/mkdir -p $HOME/.pki/nssdb
	else
		/usr/bin/mkdir -p $HOME/.pki/nssdb
	fi
fi

#list installed certificates
$certutil -L -d sql:$HOME/.pki/nssdb &> /dev/null
retcode=`echo $?`
found=false

#check if LANLWINOLT cert is installed
if [ $retcode = "0" ]; then
	$certutil -L -d sql:$HOME/.pki/nssdb | grep "LANL" &> /dev/null
	retcode=`echo $?`
	if [ $retcode = "0" ]; then
		found=true
	fi
else
	$certutil --empty-password -d sql:$HOME/.pki/nssdb -N
fi

#if not, install LANLWINOLT cert
if ! $found 
then
	$certutil -d sql:$HOME/.pki/nssdb -A -t "C,C,C" -n "LANL WIN OLT" -i $cert
fi