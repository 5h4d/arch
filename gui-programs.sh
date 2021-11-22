#!/bin/bash
#Execute this script once you boot into the gui.
echo 'This script will install: wine, lutris, steam, discord, gparted, qbittorrent, brave, python, idle, gimp, java, vlc and some gnome extensions'
echo 'Tap enter to continue...'
read tmpvar
sudo sed -i '/^#\[multilib]/{n;s/^#//}' /etc/pacman.conf
sudo sed -i 's/#\[multilib]/\[multilib]/g' /etc/pacman.conf
sudo pacman -Syu
sudo pacman -S lutris steam discord gparted qbittorrent jdk-openjdk gimp pulseaudio pavucontrol python python-pip fish vlc gtk-engine-murrine gtk-engines gnome-tweaks
pip install discover-overlay
git clone https://aur.archlinux.org/gnome-shell-extension-ubuntu-dock.git
git clone https://aur.archlinux.org/idle-python3.7-assets.git
git clone https://aur.archlinux.org/paru-git.git
git clone https://github.com/vinceliuice/Layan-gtk-theme
git clone http://aur.archlinux.org/snapper-gui-git.git
cd paru-git
makepkg -si
cd ..
cd idle-python3.7-assets
makepkg -si
cd ..
cd Layan-gtk-theme
./install.sh
cd ..
cd snapper-gui-git
makepkg -si
cd ..
sudo rm -r idle-python3.7-assets paru-git Layan-gtk-theme snapper-gui-git
unzip -d ~/.local/share/gnome-shell/ extensions.zip
rm extensions.zip
sudo pacman -S --needed lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs
echo 'Execute "pactl list sources" and copy the name of a running source. Execute "pactl list sinks" (preferably while something is playing) and copy the name of a running sink. Go to discordsoundshare.sh and replace [NAME OF MIC] with name of mic and [NAME OF OUTPUT] with the name of the output (sink).'
echo 'Save that and then open pavu, go to recording and choose "Monitor of Null Output". Go to Playback and in your desired app choose "Simultaneous Output to..........., Null Output" Open settings and try muting the sound sources until you do not hear yourself. Enjoy'
echo "If you'd like to use fish as your default shell press Enter otherwise ctrl+c"
read tmpvar
chsh -s /usr/bin/fish
