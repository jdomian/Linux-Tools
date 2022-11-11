#!/bin/bash

black_prefix='\033[30m'
red_prefix='\033[31m'
green_prefix='\033[32m'
yellow_prefix='\033[33m'
blue_prefix='\033[34m'
magenta_prefix='\033[35m'
cyan_prefix='\033[36m'
white_prefix='\033[37m'

black_bold_prefix='\033[1;30m'
red_bold_prefix='\033[1;31m'
green_bold_prefix='\033[1;32m'
yellow_bold_prefix='\033[1;33m'
blue_bold_prefix='\033[1;34m'
magenta_bold_prefix='\033[1;35m'
cyan_bold_prefix='\033[1;36m'
white_bold_prefix='\033[1;37m'

all_suffix='\033[00m'

echo -e 'Preparing to install '$green_bold_prefix'NodeJS, NPM and NVM'$all_suffix'

# Update Raspberry Pi OS
echo -e '$green_prefix'Updating Raspberry Pi OS...'$all_suffix'
sudo apt-get update -y

# Upgrade all libraries
echo -e '$green_prefix'Upgrading Raspberry Pi OS dependencies...'$all_suffix'
sudo apt-get upgrade -y

# Install GIT
echo -e '$green_prefix'Installing GIT...'$all_suffix'
sudo apt-get install git -y

# Add the repository for the latest version of NodeJS
echo -e '$green_prefix'Downloading NodeJS Setup...'$all_suffix'
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash

# Install NodeJS now that it is added to the repository list.
echo -e '$green_prefix'Installing NodeJS...'$all_suffix'
sudo apt-get install nodejs -y

# Install Node Version Manager (Just in case)
# Use: 
# $ nvm install 16
# $ nvm use 16
echo -e '$green_prefix'Installing NVM - Node Version Manager...'$all_suffix'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

echo -e '$green_prefix'Configuring NVM...'$all_suffix'
export NVM_DIR='$HOME/.nvm'
[ -s '$NVM_DIR/nvm.sh' ] && \. '$NVM_DIR/nvm.sh'
[ -s '$NVM_DIR/bash_completion' ] && \. '$NVM_DIR/bash_completion'

echo -e '$green_prefix'Updating NPM to latest major version...'$all_suffix'
sudo npm install -g npm@latest

echo -e '$green_prefix'Check versions'$all_suffix'

node -v
npm -v
nvm -v

sleep 2

echo -e '$green_prefix'Completing install...'$all_suffix'
