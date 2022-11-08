#!/bin/bash

# To install, ssh into your device, and type the following (without the # of course)
# curl https://raw.githubusercontent.com/jdomian/Raspberry-Pi/main/_installation.master.sh --output _installation.master.sh
# sudo ./_installation.master.sh

# Colors for console prompts and feedback when running script.
red_prefix="\033[31m"
green_prefix="\033[32m"
yellow_prefix="\033[33m"
blue_prefix="\033[34m"
purple_prefix="\033[35m"

red_bold_prefix="\033[1;31m"
green_bold_prefix="\033[1;32m"
yellow_bold_prefix="\033[1;33m"
blue_bold_prefix="\033[1;34m"
purple_bold_prefix="\033[1;35m"

all_suffix="\033[00m"

echo ""
PS3="Hi there! This is going to setup a bunch of stuff I use all the time! It may take a while, and along the way, I'm going to ask you a bunch of questions... and I want them answered IMMEDIATLEY! ":
initSetup=("OK, sure!" "No way Jośe!" "...like what kind of stuff?" "Quit")
select stuff in "${initSetup[@]}"; do
    case $stuff in
        "OK, sure!")
            echo "Awesome! Let's get crackin'!"
            ;;
        "No way Jośe!")
            insult="Well, well... you haven't connected this thing to the internet yet... no pirate insults for you then..."
            curl https://pirate.monkeyness.com/api/insult || echo "$insult"
            echo "See ya!"
	          break
            ;;
        "...like what kind of stuff?")
            echo "All kinds of awesome stuff, like NodeJS, Node Package Manager (NPM), NVM (Node Version Manager), Python, C++, Chrome Browser... all the web technologies I use as a Software Engineer but for physical devices... Sound Good? Trust me on this... ;)"
            ;;
	    "Quit")
	        echo "User requested exit"
	        exit
	        ;;
        *) echo "invalid option $REPLY";;
    esac
done
