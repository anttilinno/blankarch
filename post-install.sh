#!/bin/bash -

set -o nounset                                  # Treat unset variables as an error

# More of base packages
pacman -S base-devel zsh

# Xorg packages
pacman -S xorg-server xorg-xinit xf86-video-intel

# WM packages
pacman -S i3-gaps i3status xfce4-terminal rofi starship noto-fonts-emoji

# VBox special
pacman -S virtualbox-guest-utils
systemctl enable virtualbox.service

# Create user
useradd -m -G wheel, uucp -s /bin/zsh $NEW_USER
passwd $NEW_USER

# Make conf directories and copy files
mkdir -p "/home/${NEW_USER}/i3"
mkdir -p "/home/${NEW_USER}/xfce4/terminal"

cp config/.zshrc "/home/${NEW_USER}/"
cp config/.zprofile "/home/${NEW_USER}/"
cp config/.xinitrc "/home/${NEW_USER}/"

cp config/i3.config "/home/${NEW_USER}/.config/i3/config/"
cp config/terminalrc "/home/${NEW_USER}/.config/xfce4/terminal/"
cp config/starship.toml "/home/${NEW_USER}/.config/"

chown -R "${NEW_USER}:${NEW_USER}" "/home/${NEW_USER}"

# Install user packages
su - $NEW_USER

# Install yay
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..
rm -rf yay-bin

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install librewolf
yay -S librewolf-bin

