#!/bin/bash
set -e # Crash harder if something fails

# Paths
OUT_DIR="zig-out"
DISK_IMG="$OUT_DIR/disk.img"
EFI_IMG="$OUT_DIR/efi.img"
EXT2_IMG="$OUT_DIR/data.img"
KERNEL_EFI="$OUT_DIR/efi/boot/bootx64.efi"

# Sizes (in MB)
EFI_SIZE=64
EXT2_SIZE=128

echo "[*] Archi Image Builder: Forging disk..."

# 1. Create the EFI Partition Image (FAT32)
# We create a standalone filesystem first, then inject it.
rm -f $EFI_IMG
mkfs.vfat -C -F 32 -n "ARCHI_BOOT" $EFI_IMG $(($EFI_SIZE * 1024))

# 2. Deploy Kernel to EFI Image using mtools (no sudo required)
# EFI spec requires /EFI/BOOT/BOOTX64.EFI for fallback boot
mmd -i $EFI_IMG ::/EFI
mmd -i $EFI_IMG ::/EFI/BOOT
mcopy -i $EFI_IMG $KERNEL_EFI ::/EFI/BOOT/BOOTX64.EFI

echo "[+] Bootkernel injected."

# 3. Create the EXT2 Main Partition (Empty for now)
rm -f $EXT2_IMG
# Create a sparse file and format it
dd if=/dev/zero of=$EXT2_IMG bs=1M count=$EXT2_SIZE status=none
mkfs.ext2 -F -L "ARCHI_ROOT" $EXT2_IMG > /dev/null

echo "[+] EXT2 partition formatted."

# 4. Construct the GPT Disk Image
# We need space for the GPT Headers (LBA 0-33) + Partitions + Backup Headers
rm -f $DISK_IMG

# Calculate offsets (1MB alignment usually)
# We will just concat them, but we need to be careful with GPT.
# Strategy: Create a blank file large enough, partition it, then DD the parts in.

TOTAL_SIZE=$(($EFI_SIZE + $EXT2_SIZE + 4)) # +4MB for headers/padding
dd if=/dev/zero of=$DISK_IMG bs=1M count=$TOTAL_SIZE status=none

# Use sgdisk to create the GPT table
# -n partnum:start:end -t partnum:code
# EF00 = EFI System
# 8300 = Linux Filesystem
sgdisk -Z $DISK_IMG > /dev/null
sgdisk -n 1:1M:+${EFI_SIZE}M -t 1:EF00 -c 1:"EFI System" $DISK_IMG > /dev/null
sgdisk -n 2:0:+${EXT2_SIZE}M -t 2:8300 -c 2:"Archi Data" $DISK_IMG > /dev/null

echo "[+] GPT Table created."

# 5. Transplant the Filesystems
# We use 'dd' with 'conv=notrunc' to write the FS images into the disk image
# at the exact sectors defined by the 1MB alignment.
# 1MB = 2048 sectors (of 512 bytes)

# Write ESP to 1MB offset
dd if=$EFI_IMG of=$DISK_IMG bs=1M seek=1 count=$EFI_SIZE conv=notrunc status=none

# Write EXT2 to 1MB + EFI_SIZE offset
dd if=$EXT2_IMG of=$DISK_IMG bs=1M seek=$(($EFI_SIZE + 1)) count=$EXT2_SIZE conv=notrunc status=none

echo "[*] Success. Disk image at $DISK_IMG"
# Clean up intermediates
rm $EFI_IMG $EXT2_IMG
