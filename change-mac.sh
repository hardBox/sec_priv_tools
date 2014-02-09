#!/bin/sh
#
# INSTALL:
#
# cp change-mac.sh /etc/init.d/change-mac.sh
# chmod +x /etc/init.d/change-mac.sh
# update-rc.d change-mac.sh defaults
#
################################################

    # Disable the network devices
ifconfig eth0 down
ifconfig wlan0 down
ifconfig wlan1 down

    # Spoof the mac addresses
macchanger -r eth0
macchanger -A wlan0
macchanger -A wlan1

    # Re-enable the devices if wanted
#    ifconfig eth0 up
#    ifconfig wlan0 up
#    ifconfig wlan1 up
