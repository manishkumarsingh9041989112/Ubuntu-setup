
echo -e "\e[31;43m***** Running the first update ,upgrade and dist-upgrade on POP OS *****\e[0m"
sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo -e "\e[31;43m***** Installing every flatpak required *****\e[0m"
#flatpak install flathub org.gnome.gitlab.somas.Apostrophe -y
flatpak install flathub org.signal.Signal -y
flatpak install flathub org.telegram.desktop -y
flatpak install flathub com.github.micahflee.torbrowser-launcher -y
flatpak install flathub io.github.celluloid_player.Celluloid -y
flatpak install flathub com.bitwarden.desktop -y
flatpak install flathub org.keepassxc.KeePassXC -y
#flatpak install flathub com.sublimetext.three -y
#flatpak install flathub com.visualstudio.code -y
#flatpak install flathub net.sourceforge.Klavaro -y
#flatpak install flathub com.tux4kids.tuxtype -y
#flatpak install flathub com.gitlab.tipp10.tipp10 -y
#flatpak install flathub org.kde.ktouch -y
#flatpak install flathub com.calibre_ebook.calibre -y
flatpak install flathub com.github.johnfactotum.Foliate -y
flatpak install flathub org.kde.okular -y
flatpak install flathub com.github.babluboy.bookworm -y


echo -e "\e[31;43m***** Installing every snap required *****\e[0m"
sudo snap install authy --beta
sudo snap install chromium
sudo snap install opera
#sudo snap install mpv --beta
sudo snap refresh
 


sudo apt autoclean -y && sudo apt autoremove -y && sudo shutdown -r 5






