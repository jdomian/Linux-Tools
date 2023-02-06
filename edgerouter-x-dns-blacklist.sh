#!/bin/bash
# Run these lines in the SSH'd terminal of the device.
# curl https://raw.githubusercontent.com/jdomian/Raspberry-Pi/main/edgerouter-x-dns-blacklist.sh --output edgerouter-x-dns-blacklist.sh
# chmod +x edgerouter-x-dns-blacklist.sh
# sudo ./edgerouter-x-dns-blacklist.sh

configure
set system package repository blacklist components main
set system package repository blacklist description 'Britannic blacklist debian stretch repository'
set system package repository blacklist distribution stretch
set system package repository blacklist url 'https://raw.githubusercontent.com/britannic/debian-repo/master/blacklist/public/'
commit;save;exit

sudo curl -L https://raw.githubusercontent.com/britannic/debian-repo/master/blacklist/public.key | sudo apt-key add -

sudo apt-get update && sudo apt-get install -f edgeos-dnsmasq-blacklist

apt --fix-broken install

sudo apt-get clean cache
delete system image

curl -L -O https://raw.githubusercontent.com/britannic/blacklist/master/edgeos-dnsmasq-blacklist_1.2.4.7_mipsel.deb
sudo dpkg -i edgeos-dnsmasq-blacklist_1.2.4.7_mipsel.deb

sudo apt-get update && sudo apt-get install -f --only-upgrade edgeos-dnsmasq-blacklist

sudo dpkg-reconfigure edgeos-dnsmasq-blacklist

configure
set service dns forwarding blacklist disabled false
commit;save;exit
