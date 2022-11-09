#!/bin/bash
export NEWT_COLORS='
root=brightcyan,black
title=white,black
window=yellow,yellow
border=brightcyan,black
textbox=yellow,black
button=brightred,red
listbox=yellow,yellow
actlistbox=black,brightcyan
actsellistbox=white,black
roottext=brightcyan,black
'

OPTION=$(
whiptail --title "Operative Systems" \
--backtitle "Hostname:$(hostname); IPv4:$(hostname -I)--- $(date +"%d-%m-%y"):::$(date +'%T')" \
--menu "Choose your destiny..." 16 100 9 \
	"1" "The name of this script."   \
	"2" "Time since last boot."  \
	"3" "Number of processes and threads." \
	"4" "Number of context switches in the last secound." \
	"5" "How much time used in kernel mode and in user mode in the last secound." \
	"6" "Number of interupts in the last secound." \
	"9" "End script"  3>&2 2>&1 1>&3	
)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    if [ $OPTION = 1 ]; then
        echo "Option one"
    elif [ $OPTION = 2 ]; then
        echo "Option two"
    elif [ $OPTION = 3 ]; then
        echo "Option three"
    elif [ $OPTION = 4 ]; then
        echo "Option four"
    elif [ $OPTION = 5 ]; then
        echo "Option five"
    else 
        echo "Your chosen option:" $OPTION
    fi
else
    echo "You chose Cancel."
fi
