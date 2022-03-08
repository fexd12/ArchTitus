#!/usr/bin/env bash

REPOS=(
"https://github.com/danielmiessler/SecLists.git"
"https://github.com/sc0tfree/mentalist.git"
)

for PKG in "${REPOS[@]}"; do
    git clone $PKG
done

#install burp
wget -O files/burp.sh 'https://portswigger.net/burp/releases/download\?product\=community\&version\=2021.10.3\&type\=Linux'
chmod +x files/burp.sh
./files/burp.sh -q -dir /opt/BurpSuite

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

#install gobuster
go install github.com/OJ/gobuster/v3@latest

gem install haiti-hash

echo -ne "
-------------------------------------------------------------------------
                    Cleaning
-------------------------------------------------------------------------
"
# Remove no password sudo rights
sed -i 's/^%wheel ALL=(ALL) NOPASSWD: ALL/# %wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
sed -i 's/^%wheel ALL=(ALL:ALL) NOPASSWD: ALL/# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers
# Add sudo rights
sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

rm -r $HOME/ArchTitus
rm -r /home/$USERNAME/ArchTitus

# Replace in the same state
cd $pwd

echo "
###############################################################################
# Done - Please Eject Install Media and Reboot
###############################################################################
"
