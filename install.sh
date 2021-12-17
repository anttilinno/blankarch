#!/bin/bash -

set -o nounset                                  # Treat unset variables as an error

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

cat <<EOF > /mnt/root/part2.sh
# Timezone
ln -sf /usr/share/zoneinfo/Europe/Tallinn /etc/localtime

# Sync time
hwclock --systohc

# Generate locale
sed -i -e 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sed -i -e 's/#et_EE.UTF-8 UTF-8/et_EE.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf

# Set hostname
echo "blank" > /etc/hostname

echo "root:$ROOT_PASSWORD" | chpasswd

# Install system packages
pacman -S --noconfirm neovim git syslinux openssh ansible

# Configure network
systemctl enable systemd-networkd.service
systemctl enable sshd

cat <<'NET' > /etc/systemd/network/20-wired.network
[Match]
Name=enp0s3

[Network]
DHCP=yes
NET

# Configure boot loader
syslinux-install_update -i -a -m
sed -i -e 's/sda3/sda1/' /boot/syslinux/syslinux.cfg

exit # to leave the chroot
EOF

chmod a+x /mnt/root/part2.sh

arch-chroot /mnt /root/part2.sh

# Stuff here to do after exiting the chroot ... reboot perhaps.
# ...
