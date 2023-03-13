#!/bin/bash

info="
Function: Display listening TCP ports
Name: ports.sh
Required: netstat
"

if [ -z  `which netstat` ]
then
        echo -e "\e[31m'netstat' is required for this script.\e[0m\n${info}"
        exit 1
else
        match=".*:(\d{1,5})|.*(LISTEN).*"
        echo "TCP ports..."
        # solution without BASH_REGEX
        netstat -tulpn | grep "LISTEN" | awk '{ print $4 }' | sed -e 's/.*://'
        # netstat -tulpn | while read -r line; do
        #         [[ $line =~ $match ]]
        #         if [ "${BASH_REMATCH[2]}" = "LISTEN" ]
        #         then
        #                 echo "${BASH_REMATCH[1]}"
        #         fi
        # done
fi
