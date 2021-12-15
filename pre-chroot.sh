#!/bin/bash -
# vim: set expandtab ts=4 sw=4:

set -o nounset                                  # Treat unset variables as an error

# Check network connection
if nc -zw1 google.com 443; then
    echo "Detected internet connectivity ..."
else
    echo "Failed to detect internet connection!"
    exit 1
fi

# Create primary partition
echo ';' | sfdisk /dev/sda

# Create fs
mkfs.ext4 -L system /dev/sda1

# Sync clock
timedatectl set-ntp true

# Mount partition to /mnt
mount /dev/sda1 /mnt

# Strap base system
pacstrap /mnt base linux linux-firmware

# Write fstab
genfstab -U /mnt >> /mnt/etc/fstab

# Copy chroot.sh script to rooted environment
cp chroot.sh /mnt

# Chroot into newly created environment
arch-chroot /mnt
