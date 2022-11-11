#!/bin/bash

# To install...
# 1. SSH into your device form MacOS or Windows terminal app. (ssh pi@<device ip address>) 
# 2. Create a file called _start.sh in the user's root directory (for Raspberry Pi OS/Debian its '/home/pi')
# 3. Copy and paste everything on here into the new file
# 4. Go back into terminal, and run ./_start.sh
#
# OR
#
# Run these lines in the SSH'd terminal of the device.
# curl https://raw.githubusercontent.com/jdomian/Raspberry-Pi/main/_install.sh --output _install.sh
# chmod +x _install.sh
# sudo ./_install.sh
yellow_bold_prefix='\033[1;33m'
all_suffix='\033[00m'
whiptailStart='_whiptail.start.sh'

function getWhipped() {
	curl https://raw.githubusercontent.com/jdomian/Raspberry-Pi/main/_whiptail.start.sh --output _whiptail.start.sh
	chmod +x _whiptail.start.sh
	whiptailStart='_whiptail.start.sh'
}

function createCustomCommands() {
	commands='_commands.sh'
	if [ ! -f '$commands' ]; then
		echo '$commands does not exist.'
    		echo > _commands.sh
    		commands='_commands.sh'
		echo 'alias start="sudo ./_whiptail.start.sh"' >> $commands
		echo 'alias _start="sudo ./_whiptail.start.sh"' >> $commands
	fi
	
	bashProfile='.bash_profile'
	if [ ! -f '$bashProfile' ]; then
		echo '$bashProfile does not exist.'
    		echo > .bash_profile
    		bashProfile='.bash_profile'
	fi
	echo 'source ~/_commands.sh' >> $bashProfile
}

if [ ! -f '$whiptailStart' ]; then
	echo '$whiptailStart does not exist.'
	echo 'Getting files'
	getWhipped
	whiptailStart='_whiptail.start.sh'
	echo 'Creating custom commands...'
	createCustomCommands
	source ~/_commands.sh
	echo 'Good to go!'
	echo 'To start the menu , type 'yellow_bold_prefix'_start'all_suffix' or 'yellow_bold_prefix'start'all_suffix' in terminal...'
	read -p 'Press ENTER to launch or Ctrl+C to exit.'
	start
	sudo rm _install.sh
fi
