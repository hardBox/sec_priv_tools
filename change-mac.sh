#!/bin/bash
#
# cp change-mac.sh /etc/init.d/change-mac.sh
# chmod +x /etc/init.d/change-mac.sh
# update-rc.d change-mac.sh defaults


    # Disable the network devices
    ifconfig eth0 down
    ifconfig wlan0 down
    ifconfig wlan1 down
    ifconfig wlan2 down

    # Spoof the mac addresses
    /usr/local/bin/macchanger -r eth0
    /usr/local/bin/macchanger -A wlan0
    /usr/local/bin/macchanger -A wlan1
    /usr/local/bin/macchanger -A wlan2

    # Re-enable the devices
#    ifconfig eth0 up
#    ifconfig wlan0 up
