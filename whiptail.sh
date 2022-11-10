#!/bin/bash
black_prefix="\033[30m"
red_prefix="\033[31m"
green_prefix="\033[32m"
yellow_prefix="\033[33m"
blue_prefix="\033[34m"
magenta_prefix="\033[35m"
cyan_prefix="\033[36m"
white_prefix="\033[37m"

black_bold_prefix="\033[1;30m"
red_bold_prefix="\033[1;31m"
green_bold_prefix="\033[1;32m"
yellow_bold_prefix="\033[1;33m"
blue_bold_prefix="\033[1;34m"
magenta_bold_prefix="\033[1;35m"
cyan_bold_prefix="\033[1;36m"
white_bold_prefix="\033[1;37m"

all_suffix="\033[00m"

echo -e ""
sleep 0.2
echo -e "$cyan_prefix"Netrunner initalized... executing"$all_suffix"
sleep 0.2
echo -e "$green_prefix"Executing installation screen"$all_suffix"
sleep 0.2
echo -e "$yellow_prefix"...standby"$all_suffix"
sleep 0.1
echo -e "$yellow_prefix"."$all_suffix"
sleep 0.1
echo -e "$yellow_prefix"."$all_suffix"
sleep 0.1
echo -e "$yellow_prefix"."$all_suffix"
sleep 0.1
echo -e "$yellow_prefix"."$all_suffix"
sleep 0.25

function execInstall() {

    # Create Installations folder if it doesn't exist.
    installationsFolder='Installations'
    if [ -d "$installationsFolder" ]; then
        echo -e "$yellow_prefix"Installations folder exists... skipping."$all_suffix"
    else
        sudo mkdir $installationsFolder
    fi

    # Download script form Github and execute in the users home directory.
    sudo curl https://raw.githubusercontent.com/jdomian/Raspberry-Pi/main/$1 --output $1
    sudo chmod +x $1
    sudo ./$1
    sudo mv $1 $installationsFolder

    # After install, move to Installations folder.
    echo -e "$yellow_prefix"Install of "$all_suffix""$cyan_bold_prefix"$1"$all_suffix" "$yellow_prefix"complete..."$all_suffix" reloading Installation/Execute.
    sleep 3
    cd
    ./whiptail.sh
}

export NEWT_COLORS='
root=brightcyan,black
title=white,black
window=yellow,yellow
border=brightcyan,black
textbox=black,yellow
button=brightred,red
listbox=yellow,yellow
actlistbox=black,brightcyan
actsellistbox=white,black
roottext=brightcyan,black
'

OPTION=$(
whiptail --title "Netrunner::Interface -- (jdomian)" \
--backtitle "Hostname:$(hostname); IPv4:$(hostname -I)--- $(date +"%F") => $(date +'%T')" \
--menu "\nSelect an interface to install..." 25 100 10 \
	"1" "GulpJS Boilerplate Site"   \
	"2" "NodeJS Install"  \
	"3" "Headless NodeJS Express Web Server" \
	"4" "Chromium Kiosk Mode" \
	"5" "MFSB-hyperpixel2r" \
	"6" "MFSB (Rivalburn/v2)" \
    "7" "Map a Windows (SMB) Drive to Linux" \
    "8" "Turing Pi 2 Admin" \
    "9" "Reboot" \
	"10" "Quit"  3>&2 2>&1 1>&3	
)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    if [ $OPTION = 1 ]; then
        execInstall gulpjs.boilerplate.sh
    elif [ $OPTION = 2 ]; then
        execInstall nodejs.install.sh
    elif [ $OPTION = 3 ]; then
        execInstall nodejs-express-server.sh
    elif [ $OPTION = 4 ]; then
        execInstall chromium-kiosk-mode.sh
    elif [ $OPTION = 5 ]; then
        execInstall
    elif [ $OPTION = 6 ]; then
        execInstall
    elif [ $OPTION = 7 ]; then
        execInstall
    elif [ $OPTION = 8 ]; then
        execInstall
    elif [ $OPTION = 9 ]; then
        execInstall
    elif [ $OPTION = 10 ]; then
        execInstall
    else 
        echo "Your chosen option:" $OPTION
    fi
else
    echo -e "$yellow_prefix"Terminating connection..."$all_suffix"
    sleep 1
    echo -e "$red_bold_prefix"☠~FLATLINED"$all_suffix"
    sleep 3
    echo -e "$red_bold_prefix"_WIPING TRACE_"$all_suffix"
    sleep 0.2
    clear                                                                                                                                               
fi
