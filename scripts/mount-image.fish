#!/usr/bin/env fish
mkdir -p ./tmp/mnt/os
losetup -D
set IMG_LOOP (losetup -f)
losetup -o (expr 512 \* 2048) $IMG_LOOP  ./tmp/debian.img
mount -t auto $IMG_LOOP ./tmp/mnt/os
