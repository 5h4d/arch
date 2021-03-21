#!/bin/bash
umount -l /.snapshots
rm -rf /.snapshots
snapper -c root create-config /
snapper -c home create-config /home
chmod a+rx /.snapshots
chown :$username /.snapshots
rm /etc/snapper/configs/root
rm /etc/snapper/configs/home
mv rot /etc/snapper/configs/root
mv hom /etc/snapper/configs/home
ffff=$(echo "ffff" | sed -e 's/[]$.*[\^]/\\&/g' )
sed -i -e "s/ffff/${user}/g" /etc/snapper/configs/root
sed -i -e "s/ffff/${user}/g" /etc/snapper/configs/home
