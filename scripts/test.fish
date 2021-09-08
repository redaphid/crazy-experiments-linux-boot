#!/usr/bin/env fish
echo "hey there"
qemu-system-x86_64 -hda ./tmp/debian.img -m 2048 -smp cpus=4