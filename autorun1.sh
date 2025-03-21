#!/bin/bash

# Update package lists
sudo apt-get update

# Install required packages
sudo apt-get install -y adb metasploit-framework jq

# Install msfvenom
sudo gem install msfvenom

# Install ipinfo library
sudo pip3 install ipinfo

# Download and install the Metasploit APK
wget https://github.com/metasploit/metasploit-framework/releases/latest/download/Metasploit-Framework-APK.zip
unzip Metasploit-Framework-APK.zip
adb install Metasploit-Framework-APK/Metasploit.apk

echo "Setup completed. You can now run the attack script."
