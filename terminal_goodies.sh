#!/bin/bash
set -e
#
#
#Username variable
USERID=devk

# Checking if the user is root or nah!
function check_root () {
  if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 
    exit 1
  fi
}
#Check complete
function CLEAN_UPDATE() {
    echo "The clean update taking place here"
    sudo rm -rf /var/lib/apt/lists/partial
    sudo apt-get update -o Acquire::CompressionTypes::Order::=gz
    sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
    echo "The clean update is now complete: and now going for software installs"
}
function INSTALL_BASIC_UTILITIES() {
    echobanner "Basic utilities installation"
    sudo apt install apt-transport-https curl wget gnupg2 gnupg unrar unzip -y
    sudo apt install build-essential dkms linux-headers-$(uname -r) -y

}
function INSTALL_GIT() {

    echo "Git download and full install"
    sudo apt install git -y
    echo "Git install completed"
}
function INSTALL_PFETCH() {

    echo "Pfetch installer "
    wget https://github.com/dylanaraps/pfetch/archive/master.zip
    unzip master.zip
    sudo install pfetch-master/pfetch /usr/local/bin/
    ls -l /usr/local/bin/pfetch
    sudo rm -rf pfetch-master 
    echo "Pfetch installer completed"
}
function INSTALL_MICROSOFT_FONTS() {

    echo "Microsoft Truetype fonts install"
    sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y
    echo -e "\e[31;43m***** Microsoft Fonts*****\e[0m"
    echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
    sudo apt-get install ttf-mscorefonts-installer -y
    sudo fc-cache -f -v
    echo "Microsoft Truetype fonts install completed"
}
function COPY_BASHRC_AND_BASH_ALIASES() {

    echo "Copying the .bashrc files and deleting downloaded files"
    #cd ..
    sudo cp ".bashrc" /home/"$USERID"/
    sudo cp ".bash_aliases" /home/"$USERID"/
    sudo chown -R "$USERID":"$USERID" /home/"$USERID"
    
}
function INSTALL_DRACULA_GNOME_TERMINAL() {
    # Gnome-terminal Dracula theme install
    sudo apt-get install dconf-cli -y
    git clone https://github.com/dracula/gnome-terminal
    cd gnome-terminal/
    ./install.sh
   
}
function INSTALL_DRACULA_GEDIT() {
    wget https://raw.githubusercontent.com/dracula/gedit/master/dracula.xml
    FILE=/home/"$USERID"/.local/share/gedit/styles
    if [ ! -f "$FILE" ]; then
        mkdir "$FILE" && true
    fi
    sudo mv dracula.xml "$FILE"/
    
}
function INSTALL_DRACULA_GTK_THEME() {

    wget https://github.com/dracula/gtk/archive/master.zip
    unzip master.zip
    sudo mv -f gtk-master /usr/share/themes && true
    gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
    gsettings set org.gnome.desktop.wm.preferences theme "Dracula"
    sudo rm -rf gtk-master.zip
    #-----Icon Theme----------------
    wget https://github.com/dracula/gtk/files/5214870/Dracula.zip
    unzip Dracula.zip
    sudo mv -f Dracula /usr/share/icons/ && true
    gsettings set org.gnome.desktop.interface icon-theme "Dracula"

}
function INSTALL_TERMINAL_COLOUR_SCHEMES() {
    bash -c  "$(wget -qO- https://git.io/vQgMr)" 
}
CLEAN_UPDATE && INSTALL_BASIC_UTILITIES && INSTALL_GIT && INSTALL_PFETCH
INSTALL_MICROSOFT_FONTS
COPY_BASHRC_AND_BASH_ALIASES
INSTALL_DRACULA_GEDIT
INSTALL_DRACULA_GTK_THEME
INSTALL_DRACULA_GNOME_TERMINAL
CLEAN_UPDATE
sudo shutdown -r 0
INSTALL_TERMINAL_COLOUR_SCHEMES






