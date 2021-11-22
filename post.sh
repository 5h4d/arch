ln -sf /usr/share/zoneinfo/Europe/Bratislava /etc/localtime
hwclock --systohc
sed -i '0,/en_US.UTF-8/{/en_US.UTF-8/s/^#//g}' /etc/locale.gen
sed -i '/sk_SK.UTF-8/s/^#//g' /etc/locale.gen
locale-gen
echo 'LANG=en_US.UTF-8' >> /etc/locale.conf
read -p 'What do you want this system to be called?: ' archname
echo $archname >> /etc/hostname
echo '127.0.0.1     localhost' >> /etc/hosts
echo '::1           localhost' >> /etc/hosts
echo '127.0.1.1     '$archname'.localdomain    '$archname >> /etc/hosts
echo 'Root password'
passwd
read -p 'What name do you want the regular user to have?: ' username
useradd -d /home/user $username
usermod -aG wheel $username
echo 'Password for '$username
passwd $username
echo "permit persist :wheel" > /etc/doas.conf
chown $username:$username /home/user
chown $username:$username /home/user/gui-programs.sh
chown $username:$username /home/user/extensions.zip
chown $username:$username /home/user/discordsoundshare.sh
chown $username:$username /home/user/snapper-config.sh
bootctl install
echo "default arch.conf" >> /boot/loader/loader.conf
echo "editor no" >> /boot/loader/loader.conf
sed -i 's/MODULES=()/MODULES=(btrfs)/g' /etc/mkinitcpio.conf
sed -i 's/HOOKS=(base udev autodetect modconf block encrypt filesystems fsck)/HOOKS=(base udev autodetect keyboard modconf block encrypt filesystems fsck)' /etc/mkinitcpio.conf
mkinitcpio -P linux
systemctl enable NetworkManager
systemctl enable gdm.service
systemctl enable cups.service
systemctl enable snapper-timeline.timer
systemctl enable snapper-cleanup.timer
echo "All done, exit chroot and off you go.  (Don't forget to execute snapper-config.sh)"
