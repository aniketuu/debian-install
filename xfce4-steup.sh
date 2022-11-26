#!/bin/bash

printf "\033c" #reset the terminal
echo "Debian xfce4 setup script"

if [ $EUID -ne 0 ]; then
 echo "Please run as super user"
 exit 1
fi

# install themes
nala install papirus-icon-theme moka-icon-theme numix-icon-theme numix-icon-theme-circle \
  arc-theme numix-gtk-theme greybird-gtk-theme
  
# install nerd-fonts
nala install fonts-font-awesome fonts-powerline fonts-ubuntu fonts-liberation2 fonts-liberation fonts-terminus
