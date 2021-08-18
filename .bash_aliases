alias changeowner='sudo chown -R $USER:$USER $HOME'
alias fullaptupgrade='sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoclean -y && sudo apt autoremove -y'
alias shutitdown='sudo shutdown now'
alias rebootit='sudo reboot now'
alias aptcleanupgrade='sudo rm -rf /var/usr/apt/lists/* && sudo apt update -o Acquire::CompressionTypes::Order::=gz && sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoclean -y && sudo apt autoremove -y'
alias calibreupgrade='sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin'
EXPORT_ALL_VM() {
	vmlist=$(vboxmanage list vms | cut -d'"' -f 2);
	IFS=$'\n'$'\r';
	for vm in $vmlist;do vboxmanage export "$vm" -o "$vm".ova;done;
	mv -vf *.ova /media/devk/FileRepository/VirtualMachineImages/UsableImages/
}
IMPORT_ALL_VM() {
	ovafilelist=$(ls -1 *.ova);
	IFS=$'\n'$'\r';
	for vm in $ovafilelist;do vboxmanage import "$vm";done;
}



