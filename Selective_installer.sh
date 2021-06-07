#!/bin/bash
set -e
## shellcheck disable=2086
true
## shellcheck disable=1091
source all_installer_list.sh
FIRST_RUN_COMMON && REBOOT_SYSTEM
#Creating folder for temporary downloads#
mkdir ScriptDownloads
cd ScriptDownloads
#Created#

#*****************Basics************************************#
INSTALL_BASIC_UTILITIES
INSTALL_UCARESYSTEMCORE
INSTALL_TMUX
INSTALL_BPYTOP
INSTALL_GIT
#**************Fonts and Pfetch***********************************#
INSTALL_POWERLINEFONTS
INSTALL_MICROSOFT_FONTS
INSTALL_PFETCH
#************Virtualbox********************************#
if [ "$MACHINE_VIRTUAL_OR_REAL" != "$IS_VIRTUALBOX_MACHINE" ]; then
    INSTALL_VIRTUALBOX
else
    INSTALL_VBOX_GUESTADDITIONS
fi
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
INSTALL_GNOME_SOFTWARE
#*************Books************************************#
INSTALL_CALIBRE
#INSTALL_FOLIATE  #Flatpak
#INSTALL_OKULAR   #Flatpak
#INSTALL_BOOKWORM #Flatpak

#************Media*****************************************#
INSTALL_MPV
INSTALL_VLC
INSTALL_4KVIDEODOWNLOADER
INSTALL_CELLULOID #Flatpak

#************Communication*********************************#
INSTALL_TELEGRAM #Flatpak
INSTALL_SIGNAL   #Flatpak

#*******Final steps***************************************#
COPY_BASHRC_AND_BASH_ALIASES
CREATE_FOLDER_SYSTEM
REBOOT_SYSTEM
