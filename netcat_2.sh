#!/bin/bash

reset='[0m'
red='[0;31m'

general_info="
Script name: netcat.sh
Required: netcat, \e$red ROOT PRIVILEGES \e$reset
Purpose: find which ports are being used by current precesses
"

if [ `id -u` -ne 0 ]
  then
    echo -e "$general_info"
  else

    if [[ $1 == "--testing" || $1 == "-t" ]]
    then
	    sudo lsof -nPi tcp:13 |grep -i 'listen'
	    nc -l 13 &
    elif [ -z `which nc` ]
    then
	    echo -e "Netcat is required to run this script. $general_info"
	    exit 1
    fi
	
    if [[ $1 == "--help" || $1 == "-h" ]]
    then
	    man nc
    fi

    for port in {1..100}
	do
	  sudo lsof -nPi tcp:$port |grep -i 'listen'
	done
fi


