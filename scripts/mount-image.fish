#!/usr/bin/env fish
set -l TMP '/project/tmp'
mkdir -p ./tmp/mnt/os
losetup -D
set IMG_LOOP (losetup -f)
losetup -o (expr 512 \* 204) $IMG_LOOP  ./tmp/os.img
mount -t auto $IMG_LOOP ./tmp/mnt/os
