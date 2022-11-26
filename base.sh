#!/bin/bash

printf "\033c" #reset the terminal
echo "Debian base install script"

if [[ $EUID -ne 0 ]]; then
 echo "Please run as super user"
 exit 1
fi

# update to testing
echo "deb http://deb.debian.org/debian/ testing main non-free contrib" > /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian/ testing main non-free contrib" >> /etc/apt/sources.list
apt update
apt full-upgrade

# Install nala
apt install nala -y
