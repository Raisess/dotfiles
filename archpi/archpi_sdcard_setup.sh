#! /usr/bin/env bash

# @DESCRIPTION: This script installs an Arch Linux ARM into an SDCard

DEVICE=$1
IMAGE=$2

echo "ArchPI SDCard Setup | DEVICE: $DEVICE / IMAGE: $IMAGE"

echo ">>> Downloding dependencies..."
sudo pacman -S parted dosfstools
echo ">>> Done!"

# PREPARING SDCARD

echo ">>> Creating partitions..."
sudo parted /dev/$DEVICE --script -- mklabel msdos
sudo parted /dev/$DEVICE --script -- mkpart primary fat32 1 128
sudo parted /dev/$DEVICE --script -- mkpart primary ext4 128 100%
sudo parted /dev/$DEVICE --script -- set 1 boot on
sudo parted /dev/$DEVICE --script print
echo ">>> Done!"

echo ">>> Formating partitions..."
sudo mkfs.vfat -F32 /dev/"$DEVICE"1
sudo mkfs.ext4 -F /dev/"$DEVICE"2
echo ">>> Done!"

# COPYING IMAGE

echo ">>> Mouting partitions..."
sudo mkdir -p /mnt/arch/{boot,root}
sudo mount /dev/"$DEVICE"1 /mnt/arch/boot
sudo mount /dev/"$DEVICE"2 /mnt/arch/root
echo ">>> Done!"

echo ">>> Extracting image..."
sudo tar -xf $IMAGE -C /mnt/arch/root
echo ">>> Done!"

echo ">>> Copying image..."
sudo mv /mnt/arch/root/boot/* /mnt/arch/boot
echo ">>> Done!"

echo ">>> Umounting partitions..."
sudo umount /mnt/arch/boot
sudo umount /mnt/arch/root
sudo rm -rf /mnt/arch
echo ">>> Done!"
