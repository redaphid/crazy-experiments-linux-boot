#!/usr/bin/env fish
set  DISK ./tmp/os.img
set EFI_SIZE 512Mi
set EFI_OFFSET (expr (numfmt --from iec-i 1Mi) \+ (numfmt --from iec-i $EFI_SIZE))
set EFI_OFFSET_HUMAN `expr (numfmt --to iec-i $EFI_OFFSET)`

set DISK_ID (uuid)

rm $DISK 
truncate --size 4G $DISK
parted --script $DISK \
    mklabel gpt \
    mkpart "EFI" fat32 1Mi $EFI_SIZE \
    set 1 esp on \
    set 1 boot on \
    mkpart "rootfs" ext4 $EFI_OFFSET_HUMAN 100% \
;

fdisk -l $DISK

losetup -D

#root partition
set ROOT_LOOP (losetup -f)
set ROOT_DIR ./tmp/root

losetup -o $EFI_OFFSET $ROOT_LOOP $DISK


mkfs.ext4 $ROOT_LOOP
yes | tune2fs $ROOT_LOOP -U $DISK_ID

rm -rf $ROOT_DIR
mkdir -p $ROOT_DIR

mount -t ext4 $ROOT_LOOP $ROOT_DIR
rsync -ax / $ROOT_DIR

umount $ROOT_LOOP
set BOOT_LOOP (losetup -f)
set BOOT_DIR ./tmp/boot

losetup $BOOT_LOOP $DISK

rm -rf $BOOT_DIR
mkdir -p $BOOT_DIR

mount -t auto $BOOT_LOOP $BOOT_DIR
mkdir -p /project/tmp/boot/efi/EFI/boot
cp ./tmp/BOOTX64.EFI /project/tmp/boot/efi/EFI/boot/
umount ./tmp/boot
