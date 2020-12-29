#!/bin/bash
set -e
#
#
# Checking if the user is root or nah!
if [[ $EUID -ne 0 ]] ; then
    clear
    echo ""
    echo "Selective Installer must be run as root or with sudo. Now I will just exit..." 1>&2
    echo ""
    sleep 2
    exit 1
fi
#Check complete

#--------------Variables------------------------------#
DIST_CODENAME=$(lsb_release --codename | cut -f2)
DISTRO_NAME=$(lsb_release -i | cut -f2)
DATE=(date +%F_%T)
SCRIPT_VERSION=(0)
MACHINE_VIRTUAL_OR_REAL=$(sudo dmidecode -s system-manufacturer)
USERID=devk

#----------------Constants-----------------------------#
IS_VIRTUALBOX_MACHINE="innotek GmbH"

#----------------Functions----------------------------#


function WELCOME_SCREEN {
	echo "_______________________________________________________"
	echo "                                                       "
	echo "            Selective Installer                        "
	echo "            ~~~~~~~~~~~~~~~~~~~~~                      "
	echo "                                                       "
	echo "This install script will install commonly used tools on"
	echo "Ubuntu (or at least apt-based system).This list below  "
	echo "includes one or more of those:                         "
	echo " 1. Google Chrome                                      "
	echo " 2. Opera                                              "
	echo " 3. Chromium(flatpak)                                  "
	echo " 4. VirtualBox Guest additions                         "
	echo " 5. VirtualBox                                         "
	echo " 6. Git												 "
	echo " 7. Variety                                            "
	echo " 8. KeepassXC                                          "
	echo " 9. Brave Browser                                      "
	echo "10. Vivaldi                                            "
	echo "11. Microsoft Edge                                     "
	echo "12. Signal(flatpak)                                    "
	echo "13. Telegram(flatpak)                                  "
	echo "14. Calibre(Install/Update)                            "
	echo "15. VSCode(flatpak)                                    "
	echo "16. Gnome-tweaks                                       "
	echo "17. VLC											     "
	echo "18. Celluloid(flatpak)                                 "
	echo "19. Powerline fonts                                    "
	echo "20. Microsoft fonts                                    "
	echo "21. UCareSystem-core                                   "
	echo "22. Redshift                                           "
	echo "23. Neovim											 "
	echo "24. 4K Video Downloader								 "
	echo "25. Bitwarden(flatpak)                                 "
	echo "26. Tor-Browser(flatpak)								 "
	echo "27. Foliate(flatpak)                                   "
	echo "_______________________________________________________"
	echo
	echo " Selective Installer will start in 5 seconds..........."

	sleep 6
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
function FIRST_UPGRADE {
	echobanner "The first upgrade taking place here"
	sudo add-apt-repository universe -y
	sudo add-apt-repository multiverse -y
	sudo add-apt-repository restricted -y
	sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
	echobanner "The first upgrade is now complete: and now going for software installs"
	sleep 3
}
function FIRST_UPDATE {
	echobanner "The first update taking place here"
	sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
	echobanner "The first update is now complete: and now going for software installs"
	sleep 3
}
function INSTALL_BASIC_UTILITIES {
	echobanner "Basic utilities installation"
	sudo apt install apt-transport-https curl wget gnupg2 gnupg unrar unzip -y
	sudo apt install build-essential dkms linux-headers-$(uname -r) -y
	
}
#******************************The section contains individual software entries****************************************
function INSTALL_VBOX_GUESTADDITIONS {
	sleep 4
	echobanner "VirtualBox guest additions download and full install"
	sudo apt install virtualbox-guest-additions-iso -y
	echobanner "VirtualBox guest additions install completed"
}
function INSTALL_VIRTUALBOX {
	sleep 4
	echobanner "VirtualBox download and full install"
	sudo apt install virtualbox -y
	INSTALL_VBOX_GUESTADDITIONS
	echobanner "VirtualBox install completed"
}
function INSTALL_CORRETTO_JDK11 {
	sleep 4
	echobanner "Amazon JDK download and full install"
	sudo apt install java-common -y
	wget -O- https://apt.corretto.aws/corretto.key | sudo apt-key add - 
 	sudo add-apt-repository 'deb https://apt.corretto.aws stable main' -y
 	sudo apt-get update -y; 
 	sudo apt-get install -y java-11-amazon-corretto-jdk
 	sudo update-alternatives --config java
 	sudo update-alternatives --config javac
	echobanner "Amazon JDK install completed"
}
function INSTALL_NEOVIM {
	sleep 3
	echobanner "Neovim download and full install"
	sudo apt install neovim -y
	echobanner "Neovim install completed"
}
function INSTALL_VARIETY {
	sleep 3
	echobanner "Variety download and full install"
	sudo apt install variety -y
	echobanner "Variety install completed"
}
function INSTALL_GIT {
	sleep 3
	echobanner "Git download and full install"
	sudo apt install git -y
	echobanner "Git install completed"
}
function INSTALL_REDSHIFT {
	sleep 3
	echobanner "Redshift download and full install"
	sudo apt install redshift-gtk -y
	echobanner "Redshift install completed"
}
function INSTALL_QBITTORRENT {
	sleep 3
	echobanner "Qbittorrent download and full install"
	sudo apt install qbittorrent -y
	echobanner "Qbittorrent install completed"
}
function INSTALL_POWERLINEFONTS {
	sleep 3
	echobanner "Powerline fonts download and full install"
	sudo apt install fonts-powerline -y
	echobanner "Powerline fonts install completed"
}
function INSTALL_MPV {
	sleep 3
	echobanner "MPV download and full install"
	sudo apt install mpv -y
	echobanner "MPV install completed"
}
function INSTALL_VLC {
	sleep 3
	echobanner "VLC download and full install"
	sudo apt install vlc -y
	echobanner "VLC install completed"
}
function INSTALL_UCARESYSTEMCORE {
	sleep 3
	echobanner "uCareSystem Core download and full install"
	#uCareSystem installer
	#_______________________________________________
	# Name   : uCareSystem Core

	sudo add-apt-repository ppa:utappia/stable -y
	sudo apt update -y
	sudo apt-get install ucaresystem-core -y
	echobanner "uCareSystem Core install completed"
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
function ENABLE_FLATPAKS {
	echobanner "Enabling flatpak support wherever possible " 
	sudo apt update -y && sudo apt install flatpak -y 
	#sudo apt install gnome-software-plugin-flatpak -y
	sudo apt update -y
	sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
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
#----------------------Snaps installed are below-------------------------------------------

function INSTALL_TELEGRAM {
	echobanner "Installing Telegram flatpak" 
	flatpak install flathub org.telegram.desktop -y
	echobanner "Telegram flatpak installed" 
}
function INSTALL_SIGNAL {
	echobanner "Installing Signal flatpak" 
	flatpak install flathub org.signal.Signal -y
	echobanner "Signal flatpak installed" 
}
function INSTALL_TORBROWSER {
	echobanner "Installing Tor-Browser flatpak" 
	flatpak install flathub com.github.micahflee.torbrowser-launcher -y
	echobanner "Tor-Browser flatpak installed" 
}
function INSTALL_CELLULOID {
	echobanner "Installing Celluloid flatpak" 
	flatpak install flathub io.github.celluloid_player.Celluloid -y
	echobanner "Celluloid flatpak installed" 
}
function INSTALL_BITWARDEN {
	echobanner "Installing bitwarden flatpak" 
	flatpak install flathub com.bitwarden.desktop -y
	echobanner "bitwarden flatpak installed" 
}
function INSTALL_KEEPASSXC {
	echobanner "Installing KeepassXC flatpak" 
	flatpak install flathub org.keepassxc.KeePassXC -y
	echobanner "KeepassXC flatpak installed" 
}
function INSTALL_FOLIATE {
	echobanner "Installing Foliate flatpak" 
	flatpak install flathub com.github.johnfactotum.Foliate -y
	echobanner "Foliate flatpak installed" 
}
function INSTALL_OKULAR {
	echobanner "Installing Okular flatpak" 
	flatpak install flathub org.kde.okular -y
	echobanner "Okular flatpak installed" 
}
function INSTALL_BOOKWORM {
	echobanner "Installing Bookworm flatpak" 
	flatpak install flathub com.github.babluboy.bookworm -y
	echobanner "Bookworm flatpak installed" 
}
function INSTALL_CHROMIUM {
	echobanner "Installing Chromium flatpak" 
	flatpak install flathub org.chromium.Chromium -y
	echobanner "Chromium flatpak installed" 
}

#******************************End of section contains individual software entries****************************************

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
	cd GitRepos
	git clone https://github.com/manishkumarsingh9041989112/Ubuntusetup.git
	cd /home/"$USERID"
	cd ../Downloads
	mkdir Books Videos
	cd Books
	mkdir Computers Miscellany Novels
	cd ../Videos
	mkdir Computorials Tutorials Movies 
	cd /home/"$USERID"
	mkdir SharedVMFolder
	sudo chown -R "$USERID":"$USERID" /home/"$USERID"
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
function INSTALL_ALL_APT_SOFTWARE {
	echobanner "Installing apt software"
	mkdir ScriptDownloads
	cd 	  ScriptDownloads
	INSTALL_BASIC_UTILITIES
	INSTALL_VIRTUALBOX
	INSTALL_NEOVIM
	INSTALL_GIT
	INSTALL_REDSHIFT
	INSTALL_QBITTORRENT
	INSTALL_POWERLINEFONTS
	INSTALL_MPV
	INSTALL_VLC
	INSTALL_UCARESYSTEMCORE
	INSTALL_4KVIDEODOWNLOADER
	INSTALL_GOOGLECHROME
	INSTALL_NORDVPN
	#-------Issues with these two--------------#
	#INSTALL_BRAVEBROWSER
	#INSTALL_OPERABROWSER
	INSTALL_VIVALDIBROWSER	
	INSTALL_EDGEBROWSER
	INSTALL_VSCODE
	INSTALL_SUBLIMETEXT
	INSTALL_CALIBRE
	INSTALL_4KVIDEODOWNLOADER
	INSTALL_MICROSOFT_FONTS
	INSTALL_PFETCH
	INSTALL_VARIETY
	INSTALL_GNOME_SOFTWARE
	echobanner "Installing apt software donein real machines"
	## End of script
}
function INSTALL_ALL_APT_SOFTWARE_VM {
	echobanner "Installing apt software for VMs"
	mkdir ScriptDownloads
	cd 	  ScriptDownloads
	INSTALL_BASIC_UTILITIES
	INSTALL_VBOX_GUESTADDITIONS
	INSTALL_NEOVIM
	INSTALL_CORRETTO_JDK11
	INSTALL_GIT
	INSTALL_REDSHIFT
	INSTALL_POWERLINEFONTS
	INSTALL_VLC
	INSTALL_UCARESYSTEMCORE
	INSTALL_GOOGLECHROME
	INSTALL_NORDVPN
	#INSTALL_BRAVEBROWSER
	INSTALL_SUBLIMETEXT
	INSTALL_MICROSOFT_FONTS
	INSTALL_PFETCH
	echobanner "Installing apt software done in Virtual machines"
	## End of script
}
function INSTALL_ALL_FLATPAK_SOFTWARE {
	echobanner "Installing flatpak software"
	INSTALL_TELEGRAM
	INSTALL_SIGNAL
	INSTALL_TORBROWSER
	INSTALL_CELLULOID
	INSTALL_BITWARDEN
	INSTALL_KEEPASSXC
	INSTALL_FOLIATE
	INSTALL_OKULAR
	INSTALL_BOOKWORM
	INSTALL_CHROMIUM
	echobanner "Installing flatpak software done"
	## End of script
}
function RESTORE_BROWSERS {
	echobanner "Restoring browser details"
	unzip -o -d /home/"$USERID" MozillaArchive.zip
	unzip -o -d /home/"$USERID"/.config ConfigArchive.zip
	echobanner "Restore of browser details done"
	## End of script
}
function FIRST_RUN_COMMON {
	echobanner "Installing first run software"
	WELCOME_SCREEN && FIRST_UPGRADE && ENABLE_FLATPAKS && REBOOT_SYSTEM
	echobanner "Installing first run software done"
	## End of script
}
function SECOND_RUN {
	echobanner "Installing Second run software"
	if [ "$MACHINE_VIRTUAL_OR_REAL" != "$IS_VIRTUALBOX_MACHINE" ]; then
	echo "This is an actual machine set-up"	
    WELCOME_SCREEN && FIRST_UPDATE && INSTALL_ALL_APT_SOFTWARE && INSTALL_ALL_FLATPAK_SOFTWARE && COPY_BASHRC_AND_DELETE_REST && RESTORE_BROWSERS && CREATE_FOLDER_SYSTEM && REBOOT_SYSTEM
	else
    echo "This is a virtualbox machine so installing only relevant software"
    WELCOME_SCREEN && FIRST_UPDATE && INSTALL_ALL_APT_SOFTWARE_VM && COPY_BASHRC_AND_DELETE_REST && REBOOT_SYSTEM
	fi		
	
	echobanner "Installing Second run software done"
	## End of script
}
function INSTALL_BRAVE_OPERA_BROWSERS {
	echobanner "Installing Brave and Opera Browsers Separately"
	INSTALL_BRAVEBROWSER
	INSTALL_OPERABROWSER	
	echobanner "Installing Brave and Opera Browsers done"
	## End of script
}
########################Run 1########################################

FIRST_RUN_COMMON

########################Run 2########################################

SECOND_RUN && INSTALL_BRAVE_OPERA_BROWSERS






