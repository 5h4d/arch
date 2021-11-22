read -p 'What drive would you like to install to? (example: /dev/sda) Make sure the format is correct. : ' disk

read -p 'How much space on the disk would you like to dedicate to swap?(example: 20G) make sure the format is correct: ' swapsize
echo The system is going to install arch on $disk and dedicate $swapsize of storage to swap. Ctrl+C to cancel or press enter to continue.
read tmpvar

timedatectl set-ntp true
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk $disk
  g
  n


  y
  +550M
  n
  
  
  
  y
  t
  1
  1
  w
EOF
cryptsetup luksFormat $disk'2'
cryptsetup open $disk'2' root
mkfs.btrfs /dev/mapper/root
mkfs.fat -F32 $disk'1'
mount /dev/mapper/root /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@swap
umount -l /mnt
mount -o noatime,compress=lzo,subvol=@ /dev/mapper/root /mnt/
mkdir -p /mnt/{boot,home,swap}
mount -o noatime,compress=lzo,subvol=@home /dev/mapper/root /mnt/home
mount -o noatime.compress=lzo,subvol=@swap /dev/mapper/root /mnt/swap
mount $disk'1' /mnt/boot/
truncate -s 0 /mnt/swap/swapfile
chattr +C /mnt/swap/swapfile
btrfs prop set /mnt/swap/swapfile compression none
dd if=/dev/zero of=/mnt/swap/swapfile bs=$swapsize count=1 status=progress
chmod 600 /mnt/swap/swapfile
mkswap /mnt/swap/swapfile
swapon /mnt/swap/swapfile
pacstrap /mnt base base-devel linux linux-firmware linux-headers git vim gnome networkmanager neofetch cups btrfs-progs snapper doas
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
chmod +x /mnt/home/user/snapper-config.sh
mkdir -p /boot/loader/entries
echo "options cryptdevice="$disk'2:root root=/dev/mapper/root rootflags=subvolid=256' >> /boot/loader/entries/arch.conf
arch-chroot /mnt -c disk
rm -f /mnt/post.sh
