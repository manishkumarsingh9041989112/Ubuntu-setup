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
#14. Calibre
#15. Microsoft Edge
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
MACHINE_VIRTUAL_OR_REAL=$(sudo dmidecode -s system-manufacturer)
USERID=devk

#----------------Constants-----------------------------#
IS_VIRTUALBOX_MACHINE="innotek GmbH"

function scbanner()
{
  echo "+------------------------------------------+"
  printf "| %-40s |\n" "`date`"
  echo "|                                          |"
  printf "|`tput bold` %-40s `tput sgr0`|\n" "$@"
  echo "+------------------------------------------+"
}
function echobanner()
{ 
  echo $1 >> textfile.txt
  fold -w 40 -s textfile.txt > folded_textfile.txt
  (perl -lne 'printf "%-40s\n", $_' folded_textfile.txt) > textconform.txt
  textconform=$(cat textconform.txt)

  echo "+------------------------------------------+"
  echo "|          Start                           |"
  echo "+------------------------------------------+"
  printf "`tput bold`%-40s`tput sgr0`\n" "$textconform"
  echo "+------------------------------------------+"
  echo "|          End                             |"
  echo "+------------------------------------------+"

  rm -f textfile.txt folded_textfile.txt textconform.txt

}

function WELCOME_SCREEN {
    sudo apt install figlet -y
	printf "Ubuntusetup Script"|figlet -f banner -t;dater=$(date +"%d %B %Y %H:%M:%S");printf "$dater"|figlet -f standard -t
	echobanner "The Script basically installs some software after the first reboot of Ubuntu/Linux Mint/PopOS.The system expects the apt package manager to be present. As well as the first reboot is done."
	sleep 4
}
function FIRST_UPGRADE {
	echobanner "The first upgrade taking place here"
	sudo add-apt-repository universe -y
	sudo add-apt-repository multiverse -y
	sudo add-apt-repository restricted -y
	sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
	echobanner "The first upgrade is now complete: and now going for software installs"
	sleep 3
}


function FIRST_THINGS_FIRST {
	echobanner "Basic utilities installation"
	sudo apt install apt-transport-https curl wget gnupg2 gnupg unrar unzip -y
	sudo apt install build-essential dkms linux-headers-$(uname -r) -y
	
}
#******************************The section contains individual software entries****************************************
function INSTALL_GOOGLECHROME {
	sleep 4
	echobanner "Google Chrome download and full install"
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo apt install ./google-chrome-stable_current_amd64.deb -y
	echobanner "Google Chrome completed"
}
function INSTALL_NORDVPN {
	sleep 3
	echobanner "NordVPN download and base install" 
	wget https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
	sudo apt install ./nordvpn-release_1.0.0_all.deb -y
	sudo apt update -y
	sudo apt install nordvpn -y
	echobanner "NordVPN download and base install done" 
}	
function INSTALL_BRAVEBROWSER {
	sleep 3
	echobanner "Brave-browser install"
	curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
	sudo apt update -y
	sudo apt install brave-browser -y
	echobanner "Brave-browser install done"
}
function INSTALL_VIVALDIBROWSER {
	sleep 3
	echobanner "Vivaldi-browser install"
	wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add -
	sudo add-apt-repository 'deb https://repo.vivaldi.com/archive/deb/ stable main' -y
	sudo apt update -y
	sudo apt install vivaldi-stable -y
	echobanner "Vivaldi-browser install done"
}
function INSTALL_OPERABROWSER {
	sleep 3
	echobanner "Opera browser install"
	wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -
	echo "deb https://deb.opera.com/opera-stable/ stable non-free" | sudo tee /etc/apt/sources.list.d/opera-stable.list
	DEBIAN_FRONTEND='noninteractive' sudo apt-get update && sudo apt-get install opera-stable -y
	echobanner "Opera browser install completed"
}
function INSTALL_EDGEBROWSER {
	sleep 3
	echobanner "microsoft-edge-dev-browser install"
	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
	sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
	sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
	sudo rm microsoft.gpg
	sudo apt update -y
	sudo apt install microsoft-edge-dev -y
	echobanner "microsoft-edge-dev-browser install completed"
}
function INSTALL_VSCODE {
	sleep 3
	echobanner "VSCode install" 
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
	sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
	sudo apt update -y
	sudo apt install code -y
	echobanner "VSCode install completed" 
}
function INSTALL_SUBLIMETEXT {
	sleep 3
	echobanner "Adding Sublime text"
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	sudo apt update -y
	sudo apt install sublime-text -y
	echobanner "Adding Sublime text completed"
}
function INSTALL_CALIBRE {
	sleep 3
	echobanner "Calibre Ebook manager installer" 
	sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin
	echobanner "Calibre Ebook manager installer completed" 
}
function INSTALL_4KVIDEODOWNLOADER {
	sleep 3
	echobanner "4k Video Downloader installer might need version"
	wget https://dl.4kdownload.com/app/4kvideodownloader_4.13.4-1_amd64.deb
	if [[ $? -eq 0 ]]; then
	chmod +x 4k*amd64.deb
	sudo apt install ./4k*amd64.deb -y
	sudo rm -f 4k*amd64.deb
	else
	echo "4K Video Downloader install failed"
	fi	
	echobanner "4k Video Downloader installer completed"
}
#******************************End of section contains individual software entries****************************************
function INSTALL_APT_MAIN_SOFTWARE {
	sleep 3
	echobanner "Ubuntu Software install for Main computers" 
	sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y
	sudo apt install fonts-powerline virtualbox virtualbox-guest-additions-iso neovim tlp tlp-rdw clamav clamtk git mpv qbittorrent redshift-gtk -y
	echobanner "Ubuntu Software install for Main computers completed" 
}
function INSTALL_APT_VM_SOFTWARE {
	sleep 3
	echobanner "Ubuntu Software install for Virtual Machines" 
	sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y
	sudo apt install fonts-powerline virtualbox-guest-additions-iso neovim git vlc redshift-gtk -y
	echobanner "Ubuntu Software install for Virtual Machines completed" 
}
function INSTALL_MICROSOFT_FONTS {
	sleep 3
	echobanner "Microsoft Truetype fonts install"
	sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y
	echo -e "\e[31;43m***** Microsoft Fonts*****\e[0m"
	echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
	sudo apt-get install ttf-mscorefonts-installer -y
	sudo fc-cache -f -v  
	echobanner "Microsoft Truetype fonts install completed"
}
function INSTALL_PFETCH {
	sleep 3
	echobanner "Pfetch installer "
	wget https://github.com/dylanaraps/pfetch/archive/master.zip
	unzip master.zip
	sudo install pfetch-master/pfetch /usr/local/bin/
	ls -l /usr/local/bin/pfetch
	echobanner "Pfetch installer completed"
}
function ENABLE_SNAPS {
	echobanner "Enabling snap support wherever possible "

	SNAPSTOPFILE=/etc/apt/preferences.d/nosnap.pref
	if [ -f "$SNAPSTOPFILE" ]; then
		echobanner "The snap stopper file is being removed"
		sudo rm -f "$SNAPSTOPFILE"
	fi	
	sudo apt update -y && sudo apt install snapd -y
	sudo systemctl enable --now snapd apparmor
}


function ENABLE_FLATPAKS {
	echobanner "Enabling flatpak support wherever possible " 
	sudo apt update -y && sudo apt install flatpak -y 
	#sudo apt install gnome-software-plugin-flatpak -y
	sudo apt update -y
	#sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}
function INSTALL_GNOME_SOFTWARE {
	echobanner "Enabling GNOME supported wherever possible" 
	STR=$(XDG_CURRENT_DESKTOP)
	SUB='GNOME'
	if [[ "$STR" == *"$SUB"* ]]; then
	  echo "It's there."
	  sudo apt update -y 
	  sudo apt install gnome-tweaks -y
	  sudo apt install gnome-software-plugin-flatpak -y
	  sudo apt update -y
	fi
	#sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}
function REBOOT_SYSTEM {
	echobanner "Rebooting"
	sleep 4
	sudo reboot now
	## End of script
}
function CREATE_FOLDER_SYSTEM {
	echobanner "Creating a System of Folders"
	sleep 4
	cd /home/"$USERID"
	cd Documents
	mkdir GitRepos Locker LogBoxer
	cd ../Downloads
	mkdir Books Videos
	cd Books
	mkdir Computers Miscellany Novels
	cd ../Videos
	mkdir Computorials Tutorials Movies 
	cd ~
	mkdir SharedVMFolder
	## End of script
}
function COPY_BASHRC_AND_DELETE_REST {
	sleep 3
	echobanner "Copying the .bashrc files and deleting downloaded files"
	cd ..
	sudo cp ".bashrc" /home/"$USERID"/
	sudo cp ".bash_aliases" /home/"$USERID"/
	sudo chown -R "$USERID":"$USERID" /home/"$USERID"
	sudo rm -rf ScriptDownloads

}
function INSTALL_ALL_SOFTWARE {
	
	echobanner "Create  a directory for any DEB packages"
	mkdir ScriptDownloads
	cd 	  ScriptDownloads
	if [ "$MACHINE_VIRTUAL_OR_REAL" != "$IS_VIRTUALBOX_MACHINE" ]; then
	echo "This is an actual machine set-up"	
    INSTALL_GOOGLECHROME && INSTALL_NORDVPN && INSTALL_BRAVEBROWSER && INSTALL_VIVALDIBROWSER && INSTALL_CALIBRE && INSTALL_EDGEBROWSER && INSTALL_OPERABROWSER && INSTALL_VSCODE && INSTALL_SUBLIMETEXT && INSTALL_MICROSOFT_FONTS && INSTALL_PFETCH && INSTALL_4KVIDEODOWNLOADER && INSTALL_APT_MAIN_SOFTWARE
	else
    echo "This is a virtualbox machine so installing only relevant software"
    INSTALL_GOOGLECHROME  && INSTALL_VSCODE && INSTALL_SUBLIMETEXT && INSTALL_MICROSOFT_FONTS && INSTALL_PFETCH && INSTALL_APT_VM_SOFTWARE
	fi		
}
	

## Run it all ,boys
	if [ "$MACHINE_VIRTUAL_OR_REAL" = "$IS_VIRTUALBOX_MACHINE" ]; then
    echo "This is a virtualbox machine so installing only relevant software"
    WELCOME_SCREEN  && FIRST_UPGRADE && FIRST_THINGS_FIRST && INSTALL_ALL_SOFTWARE  && COPY_BASHRC_AND_DELETE_REST && REBOOT_SYSTEM
    else
    echo "This is an actual machine set-up"
    WELCOME_SCREEN  && FIRST_UPGRADE && FIRST_THINGS_FIRST && INSTALL_ALL_SOFTWARE && ENABLE_FLATPAKS && INSTALL_GNOME_SOFTWARE && CREATE_FOLDER_SYSTEM && COPY_BASHRC_AND_DELETE_REST && REBOOT_SYSTEM
	fi





