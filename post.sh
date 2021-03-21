ln -sf /usr/share/zoneinfo/Europe/Bratislava /etc/localtime
hwclock --systohc
sed -i '/en_US.UTF-8/s/^#//g' /etc/locale.gen
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
usermod -aG wheel,audio,video,optical,storage $username
echo 'Password for '$username
passwd $username
sed -i '/%wheel ALL=(ALL) ALL/s/^#//g' /etc/sudoers
chown $username:$username /home/user
chown $username:$username /home/user/gui-programs.sh
chown $username:$username /home/user/extensions.zip
chown $username:$username /home/user/discordsoundshare.sh
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager
systemctl enable gdm.service
systemctl enable cups.service
systemctl enable snapper-timeline.timer
systemctl enable snapper-cleanup-timer
systemctl enable grub-btrfs.path
umount -l /.snapshots
rm -rf /.snapshots
snapper -c root create-config /
snapper -c home create-config /home
chmod a+rx /.snapshots
chown :$username /.snapshots
rm /etc/snapper/configs/root
rm /etc/snapper/configs/home
mv root /etc/snapper/configs/root
mv hom /etc/snapper/configs/home
ffff=$(echo "ffff" | sed -e 's/[]$.*[\^]/\\&/g' )
sed -i -e "s/ffff/${username}/g" /etc/snapper/configs/root
sed -i -e "s/ffff/${username}/g" /etc/snapper/configs/home
echo 'All done, exit chroot and off you go'
