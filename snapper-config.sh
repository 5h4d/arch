#!/bin/bash
sudo umount -l /.snapshots
sudo rm -rf /.snapshots
sudo snapper -c root create-config /
sudo snapper -c home create-config /home
sudo chmod a+rx /.snapshots
sudo chown :$username /.snapshots
sudo rm /etc/snapper/configs/root
sudo rm /etc/snapper/configs/home
sudo mv rot /etc/snapper/configs/root
sudo mv hom /etc/snapper/configs/home
sudo ffff=$(echo "ffff" | sed -e 's/[]$.*[\^]/\\&/g' )
sudo sed -i -e "s/ffff/${user}/g" /etc/snapper/configs/root
sudo sed -i -e "s/ffff/${user}/g" /etc/snapper/configs/home
