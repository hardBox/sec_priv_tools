#!/bin/sh
#
# sec_priv_tools Installer
#
#################################################

# must check for dictionary file  /usr/share/dict/words
# or download and install one
echo "[] Checking for dictionary file"



echo "[] Setting up hostname rewrites"

sudo cp hostname-rewrite-files /etc/init.d/hostname-rewrite-files
sudo chmod u+x /etc/init.d/hostname-rewrite-files
sudo update-rc.d hostname-rewrite-files start 36 S .

sudo cp hostname.sh /etc/init.d/hostname.sh
sudo chmod u+x /etc/init.d/hostname.sh
sudo update-rc.d hostname.sh start 02 S .


echo "[] Setting up randmom MAC addresses at boot"

sudo apt-get install macchanger
cp change-mac.sh /etc/init.d/change-mac.sh
chmod +x /etc/init.d/change-mac.sh
update-rc.d change-mac.sh defaults
