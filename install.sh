#!/bin/bash -

set -o nounset                                  # Treat unset variables as an error

if [ -f ".env" ]; then
  . .env
else
  echo "No .env file found!"
fi

sh -c pre-chroot.sh

# Chroot into newly created environment
arch-chroot /mnt /bin/sh -c chroot.sh
