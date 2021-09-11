#!/usr/bin/env fish
sudo qemu-system-x86_64 -hda ./tmp/os.img -m 4096 -bios /usr/share/OVMF/OVMF_CODE.fd -net none