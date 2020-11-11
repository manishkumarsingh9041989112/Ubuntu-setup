#!/bin/bash
set -e
#
#
#_______________________________________________
# Ubuntu_FirstSetup_Script 
#_______________________________________________
# Name   : Ubuntu_FirstSetup_Script.sh
# Author : Someone
# Date   : 08-11-2020 (first release 08-11-2020)
# Version: 0
# System : Ubuntu Linux/PopOS!/Linux Mint,Preferably GNOME desktop
# Description: This Script does the first setup of a few software apps I find essential, add up/enable Flatpak and support 	
# 1. Google Chrome
# 2. NordVPN
# 3. Microsoft core fonts package
# 4. Vivaldi
# 5. Opera
# 6. Gnome-tweaks
# 7. Snapd(and Snap support)
# 8. Flatpak support
# 9. Virtualbox
#10. VLC
#11. Celluloid
#12. Powerline fonts
#13. Neovim
## Script starts here

# Checking if the user has run the script with "sudo" or not
if [[ $EUID -ne 0 ]] ; then
	clear
	echo ""
	echo "Ubuntu_FirstSetup_Script must be run as root or with sudo. Now the script will just exit..." 1>&2
	echo ""
	sleep 2
	exit 1
fi

#--------------Variables------------------------------#
DIST_CODENAME=$(lsb_release --codename | cut -f2)
DISTRO_NAME=$(lsb_release -i | cut -f2)
DATE=(date +%F_%T)
SCRIPT_VERSION=(0)
USERID=devk

function WELCOME_SCREEN {
	echo "_______________________________________________________"
	echo "                                                       "
	echo "            Ubuntu_FirstSetup_Script  $SCRIPT_VERSION  "
	echo "            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   "
	echo "                                                       "
	echo " The Script basically installs some software after the "
	echo " first reboot of Ubuntu/Linux Mint/PopOS.              "
	echo "                                                       "
	echo "                                                       "
	echo " The system expects the apt package manager to be      "
	echo " present                                               "
	echo "_______________________________________________________"
	echo
	echo " Ubuntu_FirstSetup_Script will start in 5 seconds...   "

	sleep 4
}
function FIRST_UPGRADE {
	echo
	echo
	echo "#################################################"
	echo "          The first upgrade taking place here    "
	echo "#################################################"
	echo
	sudo add-apt-repository universe multiverse restricted -y
	sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
	echo
	echo "######################################################################################"
	echo "          The first upgrade is now complete: and now going for software installs"
	echo "#######################################################################################"
	echo
	sleep 3
}


function FIRST_THINGS_FIRST {
	echo
	echo
	echo "#################################################"
	echo "Basic utilities installation"
	echo "#################################################"
	echo
	sudo apt install apt-transport-https curl wget gnupg2 gnupg unrar unzip -y
	sudo apt install build-essential dkms linux-headers-$(uname -r) -y
	sudo apt install libgstreamer1.0-0 gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio -y --fix-missing



}
function ENABLE_SNAPS {
	echo
	echo
	echo "#####################################################"
	echo "          Enabling snap support wherever possible  "
	echo "#####################################################"
	echo 

	SNAPSTOPFILE=/etc/apt/preferences.d/nosnap.pref
	if [ -f "$SNAPSTOPFILE" ]; then
		echo "#####################################################"
		echo "         The snap stopper file is being removed  "
		echo "#####################################################"
		sudo rm -f "$SNAPSTOPFILE"
	fi	
	sudo apt update -y && sudo apt install snapd -y
	sudo systemctl enable --now snapd apparmor
}


function ENABLE_FLATPAKS {
	echo
	echo
	echo "#####################################################"
	echo "          Enabling flatpak support wherever possible  "
	echo "#####################################################"
	echo 
	sudo apt update -y && sudo apt install flatpak -y && sudo apt install gnome-software-plugin-flatpak -y
	sudo apt update -y
	#sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}
function REBOOT_SYSTEM {
	sleep 3
	echo
	echo
	echo "#########################"
	echo "        Rebooting"
	echo "#########################"
	sudo shutdown -r 0
	## End of script
}
function COPY_BASHRC_AND_DELETE_REST {
	sleep 3
	echo
	echo
	echo "##################################################"
	echo "        Copying the .bashrc files and "
	echo "        deleting downloaded files"
	echo "##################################################"
	cd ..
	sudo cp ".bashrc" /home/"$USERID"/	
	sudo rm -rf ScriptDownloads

}
function INSTALL_ALL_SOFTWARE {
	echo
	echo
	echo "#####################################################"
	echo "          Create  a directory for any DEB packages   "
	echo "#####################################################"
	echo 	
	mkdir ScriptDownloads
	cd 	  ScriptDownloads
	echo
	echo "###########################################################"
	echo "          NordVPN download and base install                "
	echo "###########################################################"
	echo 
	wget https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
	sudo apt install ./nordvpn-release_1.0.0_all.deb -y
	echo
	echo "###########################################################"
	echo "          Google Chrome download and full install          "
	echo "###########################################################"
	echo 
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo apt install ./google-chrome-stable_current_amd64.deb -y
	echo
	echo "#################################################################"
	echo "         Adding Brave-browser,Vivaldi-browser"
	echo "#################################################################"
	echo 
	# BRAVE browser
	curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
	# Vivaldi Browser
	wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add -
	sudo add-apt-repository 'deb https://repo.vivaldi.com/archive/deb/ stable main' -y
	wget https://dl.4kdownload.com/app/4kvideodownloader_4.13.3-1_amd64.deb
	sudo apt install ./4kvideodownloader_4.13.3-1_amd64.deb -y
	sudo apt update -y
	sudo apt install nordvpn fonts-powerline virtualbox virtualbox-guest-additions-iso neovim gnome-tweaks tlp tlp-rdw clamav clamtk git mpv qbittorrent -y
	sudo apt install vivaldi-stable -y
	sudo apt install brave-browser -y 
	echo -e "\e[31;43m***** Installing pfetch*****\e[0m"
	git clone https://github.com/dylanaraps/pfetch.git
	sudo install pfetch/pfetch /usr/local/bin/

	echo -e "\e[31;43m***** Microsoft Fonts*****\e[0m"
	echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
	sudo apt-get install ttf-mscorefonts-installer -y
	sudo fc-cache -f -v  	
}

## Run it all ,boys
WELCOME_SCREEN  && FIRST_UPGRADE && FIRST_THINGS_FIRST && INSTALL_ALL_SOFTWARE && ENABLE_FLATPAKS && ENABLE_SNAPS && COPY_BASHRC_AND_DELETE_REST && REBOOT_SYSTEM




