#!/bin/bash
# Author: İhsan Hepşen (Ihsan Hepsen)

info="
Function:  Check password complexity
Name:      checkpassword.sh
Arguments: password (string)
"

if [ $# -eq 0 ]
then
    echo -e "\e[41mYou must provide a password to perform a check\e[0m\n${info}"
    exit 1
else
    if [ "${#1}" -ge 8 ]
    then
        # for unwanted password patterns
        check="(\\)|(\s)"
        if [[ $1 =~ $check ]]
        then
            echo -e "\e[31mPassword cannot cotain spaces or '\' backslashes!\e[0m]"
            exit 1
        else
            # regex match
            match="^([A-Z]).*([0-9]{2})$"
            if [[ $1 =~ $match ]]
            then
                echo -e "\e[32mYour password is OK\e[0m!"
            else
                echo -e "\e[33mYour password is NOT OK\e[0m! Please make your password stronger."
            fi
        fi
    else
        echo -e "\e[33mINVALID\e[0m. PASSWORD MUST BE AT LEAST 8-character long!"
    fi
fi
