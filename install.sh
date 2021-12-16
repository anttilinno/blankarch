#!/bin/bash -

set -o nounset                                  # Treat unset variables as an error

if [ -f ".env" ]; then
  . .env
else
  echo "No .env file found!"
fi

./pre-chroot.sh

# Run rest of the commands in chroot
cp .env /mnt
cp chroot.sh /mnt
arch-chroot /mnt ./chroot.sh
