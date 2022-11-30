#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get full-upgrade -y
sudo apt-get rpi-eeprom-update -y

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get full-upgrade -y
sudo apt-get rpi-eeprom-update -y

# Update only firmware
sudo rpi-eeprom-update -d -a
