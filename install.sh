read -p 'What drive would you like to install to? (example: /dev/sda) Make sure the format is correct. : ' disk

read -p 'How much space on the disk would you like to dedicate to swap?(example: 20G) make sure the format is correct: ' swapsize
echo The system is going to install arch on $disk and dedicate $swapsize of storage to swap. Ctrl+C to cancel or press enter to continue.
read tmpvar

pacman -S wipe
wipe $disk
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
mkfs.btrfs $disk'3'
mkfs.fat -F32 $disk'1'
mount $disk'3' /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@snapshots
umount -l /mnt
mount -o noatime,compress=lzo,subvol=@ $disk'3' /mnt/
mkdir -p /mnt/{boot,home,.snapshots}
mount -o noatime,compress=lzo,subvol=@home $disk'3' /mnt/home
mount -o noatime,compress=lzo,subvol=@snapshots $disk'3' /mnt/.snapshots
mount $disk'1' /mnt/boot/
mkswap $disk'2'
swapon $disk'2'
pacstrap /mnt base base-devel linux linux-firmware git vim gnome networkmanager grub efibootmgr dosfstools mtools neofetch cups btrfs-progs grub-btrfs snapper
genfstab -U /mnt >> /mnt/etc/fstab
mv post.sh /mnt
chmod +x /mnt/post.sh
echo 'After you are chrooted execute the second part of the script with ./post.sh'
echo 'Press enter to chroot...'
read tmpvar
mkdir /mnt/home/user
mv gui-programs.sh extensions.zip discordsoundshare.sh hom rot snapper-config.sh /mnt/home/user
chmod +x /mnt/home/user/gui-programs.sh
chmod +x /mnt/home/user/discordsoundshare.sh
arch-chroot /mnt
rm -f /mnt/post.sh
