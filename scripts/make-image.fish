#!/usr/bin/env fish
grub-mkrescue -o ./tmp/rescue.img
truncate --size 4G ./tmp/rescue.img