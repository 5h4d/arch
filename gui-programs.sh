#!/bin/bash
#Execute this script once you boot into the gui.
echo 'This script will install: wine, lutris, steam, discord, gparted, qbittorrent, spotify, brave, python, idle, gimp, java, vlc and some gnome extensions'
echo 'Tap enter to continue...'
read tmpvar
sudo sed -i '/^#\[multilib]/{n;s/^#//}' /etc/pacman.conf
sudo sed -i 's/#\[multilib]/\[multilib]/g' /etc/pacman.conf
sudo pacman -Syu
sudo pacman -S lutris steam discord gparted qbittorrent jdk-openjdk gimp pulseaudio pavucontrol python python-pip fish vlc gtk-engine-murrine gtk-engines
pip install discover-overlay
git clone https://aur.archlinux.org/gnome-shell-extension-ubuntu-dock.git
git clone https://aur.archlinux.org/idle-python3.7-assets.git
git clone https://aur.archlinux.org/spotify.git
git clone https://aur.archlinux.org/gdm-plymouth.git
git clone https://aur.archlinux.org/yay-git.git
git clone https://aur.archlinux.org/ffmpeg-compat-57.git
git clone https://aur.archlinux.org/brave-bin.git
git clone https://github.com/vinceliuice/Layan-gtk-theme
cd gnome-shell-extension-ubuntu-dock
makepkg -si
cd ..
cd yay-git
makepkg -si
cd ..
cd idle-python3.7-assets
makepkg -si
cd ..
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --import -
cd ffmpeg-compat-57
makepkg -si
cd ..
cd spotify
makepkg -si
cd ..
cd gdm-plymouth
makepkg -si
cd ..
cd brave-bin
makepkg -si
cd ..
cd Layan-gtk-theme
./install.sh
cd ..
sudo rm -r spotify gnome-shell-extension-ubuntu-dock idle-python3.7-assets gdm-plymouth yay-git ffmpeg-compat-57 brave-bin Layan-gtk-theme
unzip -d ~/.local/share/gnome-shell/ extensions.zip
rm extensions.zip
sudo pacman -S --needed lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs
brave https://wiki.archlinux.org/index.php/Plymouth
echo 'Execute "pactl list sources" and copy the name of a running source. Execute "pactl list sinks" (preferably while something is playing) and copy the name of a running sink. Go to discordsoundshare.sh and replace [NAME OF MIC] with name of mic and [NAME OF OUTPUT] with the name of the output (sink).'
echo 'Save that and then open pavu, go to recording and choose "Monitor of Null Output". Go to Playback and in your desired app choose "Simultaneous Output to..........., Null Output" Open settings and try muting the sound sources until you do not hear yourself. Enjoy'
echo "If you'd like to use fish as your default shell press Enter otherwise ctrl+c"
read tmpvar
chsh -s /usr/bin/fish
