read -p 'Are you sure you want to install Arch to /dev/sda? [y/N]: ' checkcorrectdisk
if ! [ $checkcorrectdisk = 'y' ] && ! [ $checkcorrectdisk = 'Y' ]
then 
  echo 'Edit script to install to a different drive or partitions'
  exit
fi

echo 'This script assigns 20GB of space on the disk to swap by default'
echo "If you'd like to change this press Ctrl+C and edit the script otherwise continue by pressing enter..."
read tmpvar

timedatectl set-ntp true
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk /dev/sda
  g
  n


  +550M
  n


  +20G   #edit this number to your desired swap size
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
mkdir -p /mnt/boot/EFI
mount /dev/sda1 /mnt/boot/EFI
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
