#!/bin/bash

if [ $EUID -ne 0 ]; then
 echo "Please run as super user"
 exit 1
fi

mkdir -p ~/.local/share/fonts

cd /tmp
fonts=("FiraCode" "Go-Mono" "Hack" "Inconsolata" "Iosevka" "JetBrainsMono" "Mononoki" "RobotoMono" "SourceCodePro" "UbuntuMono")

for font in ${fonts[@]}
do
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/$font.zip
    unzip $font.zip -d /home/$SUDO_USER/.local/share/fonts/$font/
    chmod 644 /home/$SUDO_USER/.local/share/fonts/$font/*
    rm $font.zip
done
fc-cache
