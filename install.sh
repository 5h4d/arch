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
mount /dev/sda1 /mnt/boot/EFI
pacstrap /mnt base base-devel linux linux-firmware git nano gnome networkmanager sudo grub efibootmgr dosfstools mtools
genfstab -U /mnt >> /mnt/etc/fstab
mv post.sh /mnt
chmod +x /mnt/post.sh
arch-chroot /mnt
echo Remove post.sh
read tmpvar
rm /mnt/post.sh
