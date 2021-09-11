#!/usr/bin/env fish
set -l DISK ./tmp/os.img
rm os.img
grub-mkrescue -o $DISK
truncate --size 4G $DISK
sgdisk $DISK -s
printf "fix\n" | parted ---pretend-input-tty $DISK print
parted --script $DISK rm 3 rm 4 resizepart 2 100%
