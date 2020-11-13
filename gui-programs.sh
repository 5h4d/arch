#Execute this script once you boot into the gui.
echo 'This script will install: wine, lutris, steam, discord, gparted, qbittorrent, spotify, google chrome, python, idle, java and some gnome extensions'
echo 'Tap enter to continue...'
read tmpvar
sudo sed -i '/^#\[multilib]/{n;s/^#//}' /etc/pacman.conf
sudo sed -i 's/#\[multilib]/\[multilib]/g' /etc/pacman.conf
sudo pacman -Syu
sudo pacman -S wine lutris steam discord gparted qbittorrent jdk-openjdk
git clone http://aur.archlinux.org/yay-git.git
git clone https://aur.archlinux.org/gnome-shell-extension-ubuntu-dock.git
git clone https://aur.archlinux.org/idle-python3.7-assets.git
git clone https://aur.archlinux.org/spotify.git
cd yay-git
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
sudo rm -r spotify yay-git gnome-shell-extension-ubuntu-dock idle-python3.7-assets
unzip -d ~/.local/share/gnome-shell/extensions extensions.zip
rm extensions.zip
yay google-chrome
sudo pacman -S lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader lib32-gnutls
