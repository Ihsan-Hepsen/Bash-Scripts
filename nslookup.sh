#!/bin/bash

info="
Function:  Convert IP addresses to names
Name:      nslookup.sh
Required:  nslookup software
"

# in case of help
if [ $1 == "-h" ]
then
	echo "$info"
	exit 0
fi

# checking if the user have the nslookup in their system, if not then give an appropriate message
if [ -z `which nslookup` ]
then
	echo -e "nslookup is required for this script.\n${info}"
	exit 1
fi

# as specified in the instructions
inputfile="ips.txt"
cat > $inputfile <<!
109.74.196.225
91.189.90.40
94.176.99.133
!

# Name: fun_nslookup
# Functionality: gets the IP address and returns the name
# Parameters: Only one parameter. IP address as parameter is required. 
fun_nslookup() {
	if [ $# -ne 1 ]
	then
		echo -e "\033[31mNo ip address provided\033[0m\n${info}"
		exit 1
	else
		match="name = (.*).$"
		cmd=`nslookup ${1} 2>/dev/null` # getting rid of the undesired error messages (if there is any)
		[[ "${cmd}" =~ $match ]]
		echo "The name of IP address ${1} is ${BASH_REMATCH[1]}"
	fi
}

# loop thru ips.txt
echo -e "\e[44mScript is running...\e[0m" 
for ip in $(cat ips.txt)
do
	fun_nslookup $ip
done
