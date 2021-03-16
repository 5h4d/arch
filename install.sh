read -p 'What drive would you like to install to? (example: /dev/sda) Make sure the format is correct. : ' disk

read -p 'What amount of storage would you like to dedicate to swap?(example: 20G) make sure the format is correct: ' swapsize
echo The system is going to install arch on $disk and dedicate $swapsize of storage to swap. Ctrl+C to cancel or press enter to continue.
read tmpvar

timedatectl set-ntp true
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk $disk
  g
  n


  +550M
  n
  
  
  
  t
  1
  1
  w
EOF
mkfs.ext4 $disk'2'
mkfs.fat -F32 $disk'1'
mount $disk'2' /mnt
mkdir -p /mnt/boot/EFI
mount $disk'1' /mnt/boot/EFI
fallocate -l $swapsize /mnt/swapfile
chmod 600 /mnt/swapfile
mkswap /mnt/swapfile
swapon /mnt/swapfile
pacstrap /mnt base base-devel linux linux-firmware git vim gnome networkmanager grub efibootmgr dosfstools mtools neofetch cups
genfstab -U /mnt >> /mnt/etc/fstab
mv post.sh /mnt
chmod +x /mnt/post.sh
echo 'After you are chrooted execute the second part of the script with ./post.sh'
echo 'Press enter to chroot...'
read tmpvar
mkdir /mnt/home/user
mv gui-programs.sh extensions.zip discordsoundshare.sh /mnt/home/user
chmod +x /mnt/home/user/gui-programs.sh
chmod +x /mnt/home/user/discordsoundshare.sh
arch-chroot /mnt
rm -f /mnt/post.sh
