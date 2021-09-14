alias changeowner='sudo chown -R $USER:$USER $HOME'
alias fullaptupgrade='sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoclean -y && sudo apt autoremove -y'
alias shutitdown='sudo shutdown now'
alias rebootit='sudo reboot now'
alias aptcleanupgrade='sudo rm -rf /var/usr/apt/lists/* && sudo apt update -o Acquire::CompressionTypes::Order::=gz && sudo apt update -y && sudo apt upgrade -y --allow-downgrades && sudo apt autoclean -y && sudo apt autoremove -y'
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
SNAPSHOT_EVERY_VM() {
	vmlist=$(vboxmanage list vms | cut -d'"' -f 2);
	IFS=$'\n'$'\r';
	for vm in $vmlist;do vboxmanage snapshot "$vm" delete "CleanSnap";done;
	for vm in $vmlist;do vboxmanage snapshot "$vm" take "CleanSnap";done;
}
function ZIP_AND_MOVE() {
    echo "The function will zip all top-level directories in the folder it is executed"
    echo "If a path is supplied as an argument ,it will move the zips to the supplied path"
    echo "Or else only zips are created in the present subdirectory and left"
    mapfile -t dirs < <(ls -d1 */)
    for directory in "${dirs[@]}"; 
    do
        echo "$directory"
        dirwithoutslash=$(echo "$directory"|sed 's:/*$::')        
        zipname=$(echo "$dirwithoutslash".zip)        
        echo "$dirwithoutslash ----------------> $zipname"        
        echo "Removing the zip file if it already exists"
        rm -rf "$zipname" || true
        zip -r "$zipname" "$dirwithoutslash"
        rm -rf "$dirwithoutslash"
        if [ -z "$1" ]
        then
        echo "No path was specified so exiting without a move"
        else
        echo "Moving the zip file to the specified path"
        mv "$zipname" "$1"
        fi
    done
    
}
function run_disowned() {
    "$@" & disown
}

function DISOWN_SILENCE_FUNCTION() {
    # run_disowned and silenced

    run_disowned "$@" 1>/dev/null 2>/dev/null
}
