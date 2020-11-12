timedatectl set-ntp true
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk /dev/sda
  g
  n


  +550M
  n


  +4G
  n



  t
  1
  1
  t
  2
  19
  w
EOF
mkfs.ext4 /dev/sda3
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mount /dev/sda3 /mnt
mkdir /mnt/boot/EFI
mount /dev/sda1 /mnt/boot/efi
pacstrap /mnt base base-devel linux linux-firmware git nano gnome networkmanager sudo
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Europe/Bratislava /etc/localtime
hwclock --systohc
sed -i '/en_US.UTF-8 UTF-8/s/^#//g'
sed -i '/sk_SK.UTF-8 UTF-8/s/^#//g'
locale-gen
echo 'LANG=en_US.UTF-8' >> /etc/locale.conf
echo 'arch' >> /etc/hostname
echo '127.0.0.1     localhost' >> /etc/hosts
echo '::1           localhost' >> /etc/hosts
echo '127.0.1.1     arch.localdomain    arch' >> /etc/hosts
echo 'Root password'
passwd
useradd yee
usermod -aG wheel,audio,video,optical,storage yee
echo 'yee password'
passwd yee
sed -i '/%wheel ALL=(ALL) ALL/s/^#//g' /etc/sudoers.tmp
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager
systemctl enable gdm.service
pacman -S wine lutris steam discord lib32-gnutls qbittorrent
echo 'All done, exit chroot and off you go'
