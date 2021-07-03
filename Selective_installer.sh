#!/bin/bash
set -e
source all_installer_list.sh
check_root
#FIRST_RUN_COMMON && INSTALL_PAPIRUS_ICON_THEME && INSTALL_GOGH_THEMES && REBOOT_SYSTEM
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
KILL_PACKAGEKITD_PROCESS
#Created#
CLEAN_UPDATE
#*****************Basics************************************#
INSTALL_BASIC_UTILITIES
INSTALL_UCARESYSTEMCORE
INSTALL_TMUX
INSTALL_BPYTOP
INSTALL_GIT
KILL_PACKAGEKITD_PROCESS
#**************Fonts and Pfetch***********************************#
INSTALL_POWERLINEFONTS
INSTALL_MICROSOFT_FONTS
INSTALL_PFETCH
KILL_PACKAGEKITD_PROCESS
#************Virtualbox********************************#
if [ "$MACHINE_VIRTUAL_OR_REAL" != "$IS_VIRTUALBOX_MACHINE" ]; then
    INSTALL_LATEST_VIRTUALBOX
fi
KILL_PACKAGEKITD_PROCESS
#******************Browsers********************************#
KILL_PACKAGEKITD_PROCESS
INSTALL_GOOGLECHROME
INSTALL_EDGEBROWSER
INSTALL_BRAVEBROWSER
INSTALL_LIBREWOLF  #Flatpak
INSTALL_CHROMIUM   #Flatpak
INSTALL_TORBROWSER #Flatpak
INSTALL_MIDORI     #Flatpak
KILL_PACKAGEKITD_PROCESS
INSTALL_VIVALDIBROWSER
INSTALL_OPERABROWSER
#*****************Text Editors**************************#
KILL_PACKAGEKITD_PROCESS
INSTALL_NEOVIM
INSTALL_VSCODIUM
INSTALL_SUBLIMETEXT
#******************JDK************************************#
#INSTALL_CORRETTO_JDK11
#************Utilities************************************#
KILL_PACKAGEKITD_PROCESS
INSTALL_ADB_AND_FASTBOOT
#INSTALL_REDSHIFT
INSTALL_QBITTORRENT
#INSTALL_ULAUNCHER
#INSTALL_AUDIORECORDER
KILL_PACKAGEKITD_PROCESS
INSTALL_NORDVPN
#INSTALL_VARIETY
INSTALL_BITWARDEN #Flatpak
INSTALL_KEEPASSXC #Flatpak
#INSTALL_GNOME_SOFTWARE
#*************Books************************************#
INSTALL_CALIBRE
KILL_PACKAGEKITD_PROCESS
#INSTALL_FOLIATE  #Flatpak
#INSTALL_OKULAR   #Flatpak
#INSTALL_BOOKWORM #Flatpak

#************Media*****************************************#
INSTALL_MPV
KILL_PACKAGEKITD_PROCESS
INSTALL_VLC
KILL_PACKAGEKITD_PROCESS
INSTALL_4KVIDEODOWNLOADER
INSTALL_VIDEO_DOWNLOADER
INSTALL_CELLULOID #Flatpak
KILL_PACKAGEKITD_PROCESS
#************Communication*********************************#
INSTALL_TELEGRAM #Flatpak
INSTALL_SIGNAL   #Flatpak
KILL_PACKAGEKITD_PROCESS
#*******Final steps***************************************#
COPY_BASHRC_AND_BASH_ALIASES
CREATE_FOLDER_SYSTEM
KILL_PACKAGEKITD_PROCESS
CLEAN_UPDATE
REBOOT_SYSTEM
