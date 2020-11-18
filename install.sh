read -p 'What drive would you like to install to? (Example: /dev/sda) Make sure the format is correct.' disk

read -p 'What amount of storage would you like to dedicate to swap?(example: 20G) make sure the format is correct: ' swapsize
echo The system is going to dedicate $swapsize of storage to swap. Ctrl+C to cancel or press enter to continue.
read tmpvar

timedatectl set-ntp true
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk $disk
  g
  n


  +550M
  n


  +$swapsize
  n



  t
  1
  1
  t
  2
  19
  w
EOF
mkfs.ext4 $disk'3'
mkfs.fat -F32 $disk'1'
mkswap $disk'2'
swapon $disk'2'
mount $disk'3' /mnt
mkdir -p /mnt/boot/EFI
mount $disk'1' /mnt/boot/EFI
pacstrap /mnt base base-devel linux linux-firmware git nano gnome networkmanager grub efibootmgr dosfstools mtools
genfstab -U /mnt >> /mnt/etc/fstab
mv post.sh /mnt
chmod +x /mnt/post.sh
echo 'After you are chrooted execute the second part of the script with ./post.sh'
echo 'Press enter to chroot...'
read tmpvar
mkdir /mnt/home/user
mv gui-programs.sh extensions.zip /mnt/home/user
chmod +x /mnt/home/user/gui-programs.sh
arch-chroot /mnt
rm -f /mnt/post.sh
