#!/bin/bash

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

# Check if the camera is enabled. 1 = disabled, 0 = enabled.
# sudo raspi-config nonint get_camera

# Enable the camera
echo -e "$green_prefix"Enabling camera module..."$all_suffix"
sudo raspi-config nonint do_camera 0 -y

# Check if i2c is enabled. 1 = disabled, 0 = enabled.
# sudo raspi-config nonint get_i2c

# Enable i2c
echo -e "$green_prefix"Enabling i2c..."$all_suffix"
sudo raspi-config nonint do_i2c 0 -y

# Update Raspberry Pi OS
echo -e "$green_prefix"Updating Raspberry Pi OS..."$all_suffix"
sudo apt-get update -y

# Upgrade all libraries
echo -e "$green_prefix"Upgrading Raspberry Pi OS dependencies..."$all_suffix"
sudo apt-get upgrade -y

# Install additional like python3 for NodeJS & NPM build tools.
echo -e "$green_prefix"Installing g++..."$all_suffix"
sudo apt-get install g++ -y

echo -e "$green_prefix"Installing gcc..."$all_suffix"
sudo apt-get install gcc -y

echo -e "$green_prefix"Installing c++ make..."$all_suffix"
sudo apt-get install make -y

echo -e "$green_prefix"Installing build-essential..."$all_suffix"
sudo apt install build-essential -y

# Install GIT
echo -e "$green_prefix"Installing GIT..."$all_suffix"
sudo apt-get install git -y 

# Install Python3-pip... this one takes a while
echo -e "$green_prefix"Installing Python 3..."$all_suffix"
sudo apt-get install python3 -y
sudo apt-get install python3-pip -y
sudo apt-get install libfontconfig -y

# Install i2c-tools
echo -e "$green_prefix"Installing i2c-tools..."$all_suffix"
sudo apt-get install i2c-tools -y

# Update again
echo -e "$green_prefix"Running update again..."$all_suffix"
sudo apt-get update -y

# Add the repository for the latest version of NodeJS
echo -e "$green_prefix"Downloading NodeJS Setup..."$all_suffix"
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash

# Install NodeJS now that it is added to the repository list.
echo -e "$green_prefix"Installing NodeJS..."$all_suffix"
sudo apt-get install nodejs -y

# Install Node Version Manager (Just in case)
# Use: 
# $ nvm install 16
# $ nvm use 16
echo -e "$green_prefix"Installing NVM - Node Version Manager..."$all_suffix"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

echo -e "$green_prefix"Configuring NVM..."$all_suffix"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

echo -e "$green_prefix"Updating NPM to latest major version..."$all_suffix"
sudo npm install -g npm@latest

# Install Gulp globally with sudo for development
echo -e "$green_prefix"Installing GulpJS CLI globally..."$all_suffix"
sudo npm install --global gulp-cli
