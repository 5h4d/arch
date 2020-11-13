ln -sf /usr/share/zoneinfo/Europe/Bratislava /etc/localtime
hwclock --systohc
sed -i '/en_US.UTF-8 UTF-8/s/^#//g' /etc/locale.gen
sed -i '/sk_SK.UTF-8 UTF-8/s/^#//g' /etc/locale.gen
locale-gen
echo 'LANG=en_US.UTF-8' >> /etc/locale.conf
echo 'arch' >> /etc/hostname
echo '127.0.0.1     localhost' >> /etc/hosts
echo '::1           localhost' >> /etc/hosts
echo '127.0.1.1     arch.localdomain    arch' >> /etc/hosts
echo 'Root password'
passwd
read -p 'What name do you want the regular user to have?: ' username
useradd -d /home/user $username
usermod -aG wheel,audio,video,optical,storage $username
echo 'Password for '$username
passwd $username
sed -i '/%wheel ALL=(ALL) ALL/s/^#//g' /etc/sudoers
chown $username:$username /home/user
chown $username:$username /home/user/gui-programs.sh
chown $username:$username /home/user/extensions.zip
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager
systemctl enable gdm.service
echo 'All done, exit chroot and off you go'
