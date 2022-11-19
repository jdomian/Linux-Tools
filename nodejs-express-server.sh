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

export NEWT_COLORS='
root=brightcyan,black
title=green,black
window=yellow,yellow
border=brightcyan,black
textbox=black,yellow
button=brightred,red
listbox=yellow,yellow
actlistbox=black,brightcyan
actsellistbox=white,black
roottext=brightcyan,black
'
# Initial Screen
function nodeOptions() {
    # Set to $1 from the portOption function, or 8000 by default.
    PORT=${1:-8000}
    STARTONBOOT=${2:-"No"}
    NODEOPTIONS=$(
    whiptail --title "NodeJS Express Server Options" \
    --backtitle "Hostname:$(hostname); IPv4:$(hostname -I)--- $(date +"%F") => $(date +'%T')" \
    --menu "\nWhat options do you want to setup?" 25 100 10 \
        "1" "Specify Port Number: $PORT"   \
        "2" "Start On Boot: $STARTONBOOT"  \
        "3" "Go Back"  \
        "4" "Quit" \
        "5" "INSTALL WITH THESE OPTIONS" \
        "6" "Delete the existing node-server install" 3>&2 2>&1 1>&3
    )

    exitstatus=$?
    if [ $exitstatus = 0 ]; then
        if [ $NODEOPTIONS = 1 ]; then
            portOptions $PORT $STARTONBOOT
        elif [ $NODEOPTIONS = 2 ]; then
            startOnBoot $PORT $STARTONBOOT
        elif [ $NODEOPTIONS = 3 ]; then
            _start
        elif [ $NODEOPTIONS = 4 ]; then
            exit
        elif [ $NODEOPTIONS = 5 ]; then
            install $PORT $STARTONBOOT
        elif [ $NODEOPTIONS = 6 ]; then
            sudo rm -rf node-server
        else 
            echo "Your chosen option:" $OPTION
        fi
    else
        echo -e "$yellow_prefix"Terminating connection..."$all_suffix"
        sleep 0.2                                                                                                                                   
    fi

}

# Port Options Screen
function portOptions() {
    PORT=$(
        whiptail --inputbox "Enter a port number you would like to use?" 8 25 --title "Port Number" 3>&1 1>&2 2>&3
    )
    nodeOptions $PORT $2
}

# Start Options Screen
function startOnBoot() {

    if (whiptail --yesno "Would you like to start the server on boot?" 8 25 --title "Start On Boat" 3>&1 1>&2 2>&3) then
        STARTONBOOT="Yes"
    else
        STARTONBOOT="No"
    fi
    nodeOptions $1 $STARTONBOOT
}

##### --- Create basic NodeJS web server --- #####
function install() {
    
    echo -e "$green_bold_prefix"Creating basic NodeJS express web server."$all_suffix"
    cd

    # Check if /node-server folder exists
    nodeServerFolder='node-server'
    if [ -d "$nodeServerFolder" ]; then
        echo "NodeJS web server folder exists... skipping"
    else
        sudo mkdir $nodeServerFolder
    fi
    cd $nodeServerFolder

    # Create server.js file for express web server
    serverJS='server.js'
    if [ -f "$serverJS" ]; then
        if (whiptail --yesno "There is a file that already exist as server.js. This will override the file and you will lose changes. Do you want to override server.js?" 8 25 --title "server.js DETECTED!" 3>&1 1>&2 2>&3) then
            # Yes
            createServerJS
        else
            # No
            echo "Skipping file..."
        fi
    else
        createServerJS
    fi

    # Create port.js file for express web server
    configJS='server.config.js'
    if [ -f "$configJS" ]; then
        if (whiptail --yesno "There is a file that already exist as server.config.js. This will change the server port to $1 and could effect other things. Do you want to make these changes?" 8 25 --title "server.config.js DETECTED!" 3>&1 1>&2 2>&3) then
            # Yes
            rm server.config.js
            createConfigJS $1
        else
            echo "Skipping port change..."
        fi
    else
        createConfigJS $1
    fi

    # Create /public directory and /public/css amd /public/js directories for web files.
    cd $nodeServerFolder
    webRootDir='public'
    if [ -d "$webRootDir" ]; then
        echo -e "$green_prefix"NodeJS web root directory \'public\' exists... skipping"$all_suffix"
        cd $webRootDir
    else
        echo "NodeJS web root directory 'public' DOES NOT exists... creating..."
        sudo mkdir public
        webRootDir='public'
        cd $webRootDir
        sudo mkdir css
        sudo mkdir js
    fi

    # Create initial HTML file in the /public directory.
    indexHTML='index.html'
    if [ -d "$indexHTML" ]; then
        echo "index.html exists... skipping"
        cd
        cd
        cd
        echo "NodeJS web server already setup. Edit index.html to test."
    else
        echo "index.html DOES NOT exists... creating..."
        echo index.html
        indexHTML = 'index.html'
        echo -e "$green_prefix"Writing index.html file for you... so you don\'t have to..."$all_suffix"
        sleep 1
        echo '<!DOCTYPE html>' | sudo tee -a $indexHTML
        echo '<html lang="en">' | sudo tee -a $indexHTML
        echo '  <head>' | sudo tee -a $indexHTML
        echo '    <meta charset="UTF-8">' | sudo tee -a $indexHTML
        echo '    <meta name="viewport" content="width=device-width, initial-scale=1.0">' | sudo tee -a $indexHTML
        echo '    <meta http-equiv="X-UA-Compatible" content="ie=edge">' | sudo tee -a $indexHTML
        echo '    <title>NodeJS Server - HTML5 Boilerplate</title>' | sudo tee -a $indexHTML
        echo '    <link rel="stylesheet" href="css/style.css">' | sudo tee -a $indexHTML
        echo '  </head>' | sudo tee -a $indexHTML
        echo '  <body>' | sudo tee -a $indexHTML
        echo '    <h1>NodeJS Express Server</h1>' | sudo tee -a $indexHTML
        echo '    <script src="js/index.js"></script>' | sudo tee -a $indexHTML
        echo '  </body>' | sudo tee -a $indexHTML
        echo '</html>' | sudo tee -a $indexHTML
    fi

    cd
    cd node-server
    # Install NodeJS NPM dependencies
    sudo npm init -y
    sudo npm install
    sudo npm install express

    if [ $2 = "Yes" ]; then
        createStartOnBoot $1 $2
    else
        rm .bash_profile
        sudo cp .bash_profile.old .bash_profile
    fi

    startNodeServer $1

    exit

}

function createServerJS() {
    echo -e "$green_prefix"Creating the server for you..."$all_suffix"
    sleep 1
    echo "NodeJS server DOES NOT file exists... creating basic NodeJS Express web server..."
    sudo touch server.js
    serverJS='server.js'
    echo "// This is a basic NodeJS Web Server. " | sudo tee -a $serverJS
    echo "const express = require('express');" | sudo tee -a $serverJS
    echo "const app = express();" | sudo tee -a $serverJS
    echo "const os = require('os');" | sudo tee -a $serverJS
    echo "const interfaces = os.networkInterfaces();" | sudo tee -a $serverJS
    echo "const serverIP = interfaces;" | sudo tee -a $serverJS
    echo "const config = require('./server.config');" | sudo tee -a $serverJS
    echo "const port = config.port;" | sudo tee -a $serverJS
    echo "" | sudo tee -a $serverJS
    echo "const server = {" | sudo tee -a $serverJS
    echo "    init() {" | sudo tee -a $serverJS
    echo "        let addresses = [];" | sudo tee -a $serverJS
    echo "        for (let i in interfaces) {" | sudo tee -a $serverJS
    echo "            for (let i2 in interfaces[i]) {" | sudo tee -a $serverJS
    echo "                let address = interfaces[i][i2];" | sudo tee -a $serverJS
    echo "                if (address.family === 'IPv4' && !address.internal) {" | sudo tee -a $serverJS
    echo "                    addresses.push(address.address);" | sudo tee -a $serverJS
    echo "                }" | sudo tee -a $serverJS
    echo "            }" | sudo tee -a $serverJS
    echo "        }" | sudo tee -a $serverJS
    echo "        app.listen(port, () => {" | sudo tee -a $serverJS
    echo "                console.log(\`NodeJS Express Server Started!\`);" | sudo tee -a $serverJS
    echo "                console.log(\`Open a browser and go to http://\${addresses}:\${port} to access the main page.\`);" | sudo tee -a $serverJS
    echo "                console.log(\`Files for this server are located at on this device at \${__dirname}.\`);" | sudo tee -a $serverJS
    echo "                console.log(\`Press Ctrl+C to kill the server.\`);" | sudo tee -a $serverJS
    echo "            }" | sudo tee -a $serverJS
    echo "        );" | sudo tee -a $serverJS
    echo "        app.get('/test', (req, res) => {" | sudo tee -a $serverJS
    echo "            res.send(\`Test request made from \${req.ip}.\`);" | sudo tee -a $serverJS
    echo "            console.log(\`Test request made from \${req.ip}.\`);" | sudo tee -a $serverJS
    echo "        });" | sudo tee -a $serverJS
    echo "    }" | sudo tee -a $serverJS
    echo "}" | sudo tee -a $serverJS
    echo "" | sudo tee -a $serverJS
    echo "server.init();" | sudo tee -a $serverJS
    echo "app.use(express.static(__dirname + '/public'));" | sudo tee -a $serverJS
}

function createConfigJS() {
    echo "NodeJS server DOES NOT exists... creating basic NodeJS Express web server..."
    echo -e "$green_prefix"Setting up server configuration..."$all_suffix"
    sleep 1
    sudo touch server.config.js
    configJS='server.config.js'
    echo "// Change the port and other configs of the NodeJS Express server here. " | sudo tee -a $configJS
    echo "module.exports = { port: $1 };" | sudo tee -a $configJS
}

function createStartOnBoot() {
    # Add command to .bash_profile to start node server.js on boot.
    bashProfile='.bash_profile'
    if [ -d "$bashProfile" ]; then
        echo "$bashProfile exists."
        echo "Backing up existing $bashProfile"
        sudo cp .bash_profile .bash_profile.old
        
    else 
        echo "$bashProfile does not exist."
        echo -e "$green_prefix"Creating startup .bash_profile..."$all_suffix"
    fi
    sudo touch .bash_profile
    echo "source ./_commands.sh" >> $bashProfile
    echo "# Start NodeJS Web Server on boot" >> $bashProfile
    echo 'node ~/node-server/server.js < /dev/null &' >> $bashProfile
}

function startNodeServer() {
    if (whiptail --yesno "The NodeJS Express server is setup. \
    \n\nWould you like to start the server now?" 15 25 --title "Start Node Server?" 3>&1 1>&2 2>&3) then
        # Yes
        cd
        cd
        cd node-server
        node server.js
        echo -e "$green_prefix"Starting Node Server..."$all_suffix"
        sleep 1
    else
        # No
        echo "Skipping file..."
    fi

    echo "$green_bold_prefix"Node Server started. Open a browser and go to: $(hostname -I):$1"$all_suffix"
    echo "To edit html, css and js files, go to $USER/node-server/."
}

nodeOptions
