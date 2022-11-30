#!/bin/bash

sudo apt-get update -y

# Update only firmware
echo "Updating firmware..."
sudo rpi-eeprom-update -d -a
