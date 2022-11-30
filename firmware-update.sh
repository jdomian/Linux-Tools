#!/bin/bash

sudo apt-get update -y

# Update only firmware/eeprom
echo "Updating firmware..."
sudo rpi-eeprom-update -d -a
