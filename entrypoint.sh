#!/bin/bash

set -e

#BW_PASSWORD_FILE points to a file in the fs

for varname in BW_CLIENTID BW_CLIENTSECRET BW_PASSWORD_FILE BW_SERVER
do
   if [ -z "${!varname}" ];then
	echo "$varname has no value"
	exit 1
   else
	#echo "$varname has value ->${!varname}<-"
	echo "$varname is set"
   fi
done 
bw config server ${BW_SERVER}

echo "Using apikey to log in"
bw login --apikey --raw
export BW_SESSION=$(bw unlock --passwordfile ${BW_PASSWORD_FILE} --raw)

bw unlock --check

echo 'Running `bw server` on port 8087'
bw serve --hostname 0.0.0.0 #--disable-origin-protection
