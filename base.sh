#!/bin/bash

printf "\033c" #reset the terminal
echo "Debian base install script"

if [ $EUID -ne 0 ]; then
 echo "Please run as super user"
 exit 1
fi

# lightdm conf
sed -i "s/^#greeter-hide-users=false$/greeter-hide-users=false/" /etc/lightdm/lightdm.conf

# update to testing
echo "deb http://deb.debian.org/debian/ testing main non-free contrib" > /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian/ testing main non-free contrib" >> /etc/apt/sources.list
apt update
apt full-upgrade

# Install nala
apt install nala -y

# install apps
nala install htop neofetch bash-completion mpv feh zathura blueman vim kitty xterm mesa-utils git

# 32 bit stuff
read -p "want 32-bit packages? [y/N] " BIT32
if [ $BIT32 == "y" ]; then
  dpkg --add-architecture i386
  nala update
  nala upgrade
fi

# nvidia
read -p "using nvidia? [y/N] " NVI
if [ $NVI == "y" ]; then
  nala install nvidia-driver firmware-misc-nonfree
  echo 'alias prime-run="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia"' >> /home/$SUDO_USER/.bashrc
  if [ $BIT32 == "y" ]; then
    nala install nvidia-driver-libs:i386
  fi
fi

# steam
read -p "want steam? [y/N] " STEAM
if [ $STEAM == "y" ]; then
  if [ $BIT32 != "y" ]; then
    echo "Enable 32 BIT first"
  fi
  nala install steam mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386
fi
  
# install qemu/kvm
read -p "install qemu/kvm? [y/N] " VM
if [[ $VM = "y" ]]; then
  nala install libvirt-daemon-system libvirt-clients qemu-system-x86 qemu-utils virt-manager ovmf bridge-utils
  mkdir /var/lib/libvirt/isos
fi

# windscribe
read -p "install windscribe? [y/N] " WINSCRB
if [[ $WINSCRB = "y" ]]; then
  cd /tmp
  wget https://assets.staticnetcontent.com/desktop/linux/windscribe-cli_1.4-51_amd64.deb
  nala install resolvconf openvpn
  dpkg -i windscribe-cli_1.4-51_amd64.deb
  echo "please reboot your system"
fi
