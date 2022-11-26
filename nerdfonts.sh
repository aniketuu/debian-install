
#!/bin/bash
sudo mkdir -p ~/.local/share/fonts

cd /tmp
fonts=( 
"FiraCode" 
"Go-Mono" 
"Hack" 
"Inconsolata" 
"Iosevka" 
"JetBrainsMono" 
"Mononoki" 
"RobotoMono" 
"SourceCodePro" 
"UbuntuMono"
)

for font in ${fonts[@]}
do
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/$font.zip
    unzip $font.zip -d /home/$USER/.local/share/fonts/$font/
    chmod 644 /home/$USER/.local/share/fonts/$font/*
    rm $font.zip
done
fc-cache
