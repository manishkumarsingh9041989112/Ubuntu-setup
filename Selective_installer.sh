#!/bin/bash
set -e
source all_installer_list.sh
check_root
SHUT_UNATTENDED_UPGRADES && CLEAN_UPDATE && ENABLE_FLATPAKS && REBOOT_SYSTEM
#Creating folder for temporary downloads#
if [ -d "./ScriptDownloads" ] 
then
    echo "Directory ScriptDownloads exists.So,deleting it" 
    sudo rm -rf ./ScriptDownloads
else
    echo "Directory ScriptDownloads does not exists, so all fine"
fi
mkdir ScriptDownloads
cd ScriptDownloads
#Created#
CLEAN_UPDATE
#*****************Basics************************************#
INSTALL_BASIC_UTILITIES
INSTALL_UCARESYSTEMCORE
INSTALL_TMUX
INSTALL_BPYTOP
#**************Fonts and Pfetch***********************************#
INSTALL_POWERLINEFONTS
INSTALL_MICROSOFT_FONTS
INSTALL_PFETCH
#************Virtualbox********************************#
INSTALL_LATEST_VIRTUALBOX
#******************Browsers********************************#

INSTALL_GOOGLECHROME
INSTALL_EDGEBROWSER
INSTALL_BRAVEBROWSER
INSTALL_LIBREWOLF  #Flatpak
INSTALL_CHROMIUM   #Flatpak
INSTALL_TORBROWSER #Flatpak
INSTALL_MIDORI     #Flatpak
INSTALL_VIVALDIBROWSER
INSTALL_OPERABROWSER
#*****************Text Editors**************************#

INSTALL_NEOVIM
INSTALL_VSCODIUM
INSTALL_SUBLIMETEXT
#******************JDK************************************#
#INSTALL_CORRETTO_JDK11
#************Utilities************************************#

INSTALL_ADB_AND_FASTBOOT
#INSTALL_REDSHIFT
INSTALL_QBITTORRENT
#INSTALL_ULAUNCHER
#INSTALL_AUDIORECORDER

INSTALL_NORDVPN
#INSTALL_VARIETY
INSTALL_BITWARDEN #Flatpak
INSTALL_KEEPASSXC #Flatpak
#INSTALL_GNOME_SOFTWARE
#*************Books************************************#
INSTALL_CALIBRE
#INSTALL_FOLIATE  #Flatpak
#INSTALL_OKULAR   #Flatpak
#INSTALL_BOOKWORM #Flatpak

#************Media*****************************************#
INSTALL_MPV
INSTALL_SMPLAYER
INSTALL_VLC
INSTALL_4KVIDEODOWNLOADER
INSTALL_VIDEO_DOWNLOADER
#INSTALL_CELLULOID #Flatpak

#************Communication*********************************#
INSTALL_TELEGRAM #Flatpak
INSTALL_SIGNAL   #Flatpak

#*******Final steps***************************************#
COPY_BASHRC_AND_BASH_ALIASES
CREATE_FOLDER_SYSTEM
INSTALL_FIRETOOLS
INSTALL_OPENSNITCH
INSTALL_BLEACHBIT
CLEAN_UPDATE
REBOOT_SYSTEM
