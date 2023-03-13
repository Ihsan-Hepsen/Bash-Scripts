#!/bin/bash

info="
Function: Timer
Reference: man date
Required: dialog
Name: timekeeping.sh
Author: Ihsan Hepsen
"
if [ -z `which dialog` ]
then
    echo -e "\e[31mpackage 'dialog' is required for this script.\e[0m\n$info"
	exit 1
else
    start=`date +%s%N`
    dialog --title "Hello" --msgbox "$(date)" 7 40
    end=`date +%s%N`
    nano_secs=$((end - start))
    mili_secs=$(($nano_secs/1000000))
    secs=$(($mili_secs/1000))
    echo "Script took: $secs seconds, $mili_secs miliseconds, $nano_secs nanoseconds"
fi
