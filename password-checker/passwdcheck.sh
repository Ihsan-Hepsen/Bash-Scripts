#!/bin/bash

info="
Function: Check password complexity
Name: checkpassword.sh
Author: Ihsan Hepsen
"

if [ $# -ne 1 ]
then
    echo -e "\e[31mYou must provide a password to perform a check\e[0m\n${info}"
	exit 1
else
	contains="(\\|\s)"
	if [ ${#1} -le 8 ]
	then
		echo -e "\e[31mPassword is too short! Plaese make sure your password is at least 8-character long.\e[0m"
	else
		if [[ $1 =~ $contains ]]
		then
			echo "Password should not contain any spaces or back slashes!"
			exit 1
		else
			match="^[A-Z]{1}.+[0-9]{1,2}$"
			if [[ $1 =~ $match ]]
			then
				echo "Your password is STRONG (9/10)!"
			else
				echo "Your password is OK (6/10)!"
			fi
		fi
	fi	
fi
