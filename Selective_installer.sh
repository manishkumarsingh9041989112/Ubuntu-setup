#!/bin/bash
set -e
source all_installer_list.sh
check_root
SHUT_UNATTENDED_UPGRADES && CLEAN_UPDATE && ENABLE_FLATPAKS
REBOOT_SYSTEM
#*****************Basics************************************#
INSTALL_BASIC_UTILITIES
INSTALL_UCARESYSTEMCORE
INSTALL_TMUX
INSTALL_BPYTOP
#**************Fonts and Pfetch***********************************#
INSTALL_POWERLINEFONTS
INSTALL_MICROSOFT_FONTS
INSTALL_PFETCH
#************Tools and Utilities********************************#
INSTALL_LATEST_VIRTUALBOX
INSTALL_VERACRYPT
INSTALL_ADB_AND_FASTBOOT
#INSTALL_REDSHIFT
INSTALL_QBITTORRENT
INSTALL_ULAUNCHER
#INSTALL_AUDIORECORDER
INSTALL_NORDVPN
INSTALL_MULLVADVPN
INSTALL_VARIETY
INSTALL_BITWARDEN #Flatpak
INSTALL_KEEPASSXC #Flatpak
#******************Browsers********************************#
INSTALL_GOOGLECHROME
INSTALL_EDGEBROWSER
INSTALL_BRAVEBROWSER
INSTALL_WATERFOX
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
#*************Books************************************#
INSTALL_CALIBRE
#INSTALL_FOLIATE  #Flatpak
#INSTALL_OKULAR   #Flatpak
#INSTALL_BOOKWORM #Flatpak

#************Media*****************************************#
INSTALL_MPV
INSTALL_VLC
INSTALL_CLAPPER #Flatpak
INSTALL_4KVIDEODOWNLOADER
INSTALL_VIDEO_DOWNLOADER
#INSTALL_CELLULOID #Flatpak

#************Communication*********************************#
INSTALL_TELEGRAM #Flatpak
INSTALL_SIGNAL   #Flatpak

#*******Final steps***************************************#
COPY_BASHRC_AND_BASH_ALIASES
INSTALL_FIRETOOLS
#INSTALL_OPENSNITCH
#INSTALL_BLEACHBIT   ----------bleachbit has root error-----
CLEAN_UPDATE
#CREATE_FOLDER_SYSTEM
REBOOT_SYSTEM
