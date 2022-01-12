#!/bin/bash -

set -o nounset                                  # Treat unset variables as an error

NEW_USER=${NEW_USER:-antti}

# More of base packages
pacman -S --noconfirm base-devel zsh

# Xorg packages
pacman -S --noconfirm xorg-server xorg-xinit xf86-video-intel xf86-video-vmware

# WM packages
pacman -S --noconfirm i3-gaps i3status xfce4-terminal rofi starship noto-fonts-emoji

# VBox special
pacman -S --noconfirm virtualbox-guest-utils
systemctl enable vboxservice.service

# Create user
useradd -m -G wheel,uucp -s /bin/zsh "${NEW_USER}"
passwd "${NEW_USER}"

# Modify sudo
echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel
chmod 0400 /etc/sudoers.d/wheel

# Make conf directories and copy files
mkdir -p "/home/${NEW_USER}/.config/i3"
mkdir -p "/home/${NEW_USER}/.config/xfce4/terminal"

cp config/.zshrc "/home/${NEW_USER}/"
cp config/.zprofile "/home/${NEW_USER}/"
cp config/.xinitrc "/home/${NEW_USER}/"

cp config/i3.config "/home/${NEW_USER}/.config/i3/config"
cp config/terminalrc "/home/${NEW_USER}/.config/xfce4/terminal/"
cp config/starship.toml "/home/${NEW_USER}/.config/"

chown -R "${NEW_USER}:${NEW_USER}" "/home/${NEW_USER}"

# Install user packages
su - "${NEW_USER}" << "EOF"

# Install yay
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si --noconfirm
cd ..
rm -rf yay-bin

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install librewolf
yay -S --noconfirm librewolf-bin
EOF

