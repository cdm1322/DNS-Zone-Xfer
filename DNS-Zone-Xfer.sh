#!/bin/bash

# Argument $1: Target Address
usage="--------------------------------------------------------------------
Usage:   $0 <target> [-o output-file]
Examples:
$0 google.com -o domains-found.txt
$0 microsoft.com -o /tmp/domains.txt
$0 yahoo.com
--------------------------------------------------------------------"
echo "
  ____  _   _ ____       _____                    __  __ __           
 |  _ \| \ | / ___|     |__  /___  _ __   ___     \ \/ // _| ___ _ __ 
 | | | |  \| \___ \ _____ / // _ \| '_ \ / _ \_____\  /| |_ / _ \ '__|
 | |_| | |\  |___) |_____/ /_ (_) | | | |  __/_____/  \|  _|  __/ |   
 |____/|_| \_|____/     /____\___/|_| |_|\___|    /_/\_\_|  \___|_|   

Courtesy of Debifrank
"

if [ -z "$1" ] || [ $# == 2 ] || [ "$1" == "-h" ] || [ "$1" == "--help" ] || [ $# -ge 4 ]; then
	echo "$usage";
	exit 0;
elif [ $# == 3 ]; then
	if [ ! $2 == "-o" ]; then
		echo "$usage";
		exit 0;
	fi
	outFile=$3
fi



echo "##>Grabbing DNS servers for target: $1<##"
DNS=$( host -t ns $1 | cut -d " " -f 4 | cut -d "." -f 1-3 );
if [ -z "$DNS" ]; then
	echo "--------------------------------------------------------------------";
	echo "Failed to find any DNS servers. Sorry :(";
	echo "--------------------------------------------------------------------";
	exit 0;
else
	echo "--------------------------------------------------------------------";
	echo "Found DNS Servers!";
	echo "--------------------------------------------------------------------";
	for ns in $DNS; do
		echo $ns;
	done;
	echo "--------------------------------------------------------------------";
fi

for ns in $DNS; do
	echo "##>Attempting Zone-Xfer on DNS server: $ns<##";
	HOSTS=$( host -l $1 $ns | grep "has address" );
	if [ -z "$HOSTS" ]; then
		echo "Failed to Zone-Xfer on $ns";
		echo "--------------------------------------------------------------------"
	else
		echo "Domains found!"
		echo "--------------------------------------------------------------------"
		echo "$HOSTS"
		echo "--------------------------------------------------------------------"
		echo "$HOSTS" > $outFile
	fi
done;
