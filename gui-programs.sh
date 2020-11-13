#Execute this script once you boot into the gui.
echo 'This script will install: wine, lutris, steam, discord, gparted, qbittorrent, spotify, google chrome, python, idle, java and some gnome extensions'
echo 'Tap enter to continue...'
read tmpvar
sudo sed -i '/^#\[multilib]/{n;s/^#//}' /etc/pacman.conf
sudo sed -i 's/#\[multilib]/\[multilib]/g' /etc/pacman.conf
sudo pacman -Syu
sudo pacman -S lutris steam discord gparted qbittorrent jdk-openjdk
git clone https://aur.archlinux.org/google-chrome.git
git clone https://aur.archlinux.org/gnome-shell-extension-ubuntu-dock.git
git clone https://aur.archlinux.org/idle-python3.7-assets.git
git clone https://aur.archlinux.org/spotify.git
cd google-chrome
makepkg -si
cd ..
cd gnome-shell-extension-ubuntu-dock
makepkg -si
cd ..
cd idle-python3.7-assets
makepkg -si
cd ..
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --import -
cd spotify
makepkg -si
cd ..
sudo rm -r spotify google-chrome gnome-shell-extension-ubuntu-dock idle-python3.7-assets
unzip -d ~/.local/share/gnome-shell/extensions extensions.zip
rm extensions.zip
sudo pacman -S lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs
