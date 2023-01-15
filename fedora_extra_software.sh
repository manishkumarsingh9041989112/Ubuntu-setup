sudo dnf remove transmission-gtk hexchat pidgin libreoffice* -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo reboot now
flatpak install flathub org.keepassxc.KeePassXC -y
flatpak install flathub com.bitwarden.desktop -y
flatpak install flathub com.google.Chrome -y
flatpak install flathub com.github.johnfactotum.Foliate -y
flatpak install flathub org.kde.okular -y
flatpak install flathub de.haeckerfelix.Shortwave -y
flatpak install flathub com.github.paolostivanin.OTPClient -y
flatpak install flathub org.telegram.desktop -y
flatpak install flathub org.signal.Signal -y
flatpak install flathub io.gitlab.librewolf-community -y
flatpak install flathub com.brave.Browser -y
flatpak install flathub org.onlyoffice.desktopeditors -y
flatpak install flathub com.github.geigi.cozy -y
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
sudo dnf install sublime-text -y
sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
sudo dnf install codium -y




