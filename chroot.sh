#!/bin/bash -

set -o nounset                                  # Treat unset variables as an error

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
echo "${HOSTNAME}" > /etc/hostname

echo "root:$ROOT_PASSWORD" | chpasswd

# Install system packages
pacman -S --noconfirm neovim git syslinux

# Configure network
systemctl enable systemd-networkd.service

cat <<'EOF' > /etc/systemd/network/20-wired.network
[Match]
Name=enp0s3

[Network]
DHCP=yes
EOF

# Configure boot loader
syslinux-install_update -i -a -m
sed -i -e 's/sda3/sda1/' /boot/syslinux/syslinux.cfg
