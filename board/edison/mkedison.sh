#! /bin/sh

IMAGES_DIR=$1

OUTPUT_BASE=$IMAGES_DIR/edison

OUTPUT=$OUTPUT_BASE.img
OUTPUT_XFSTK=$OUTPUT_BASE.xfstk.img

OSIP=$IMAGES_DIR/../../board/edison/osip.bin
ROOTFS=$IMAGES_DIR/rootfs.ext4
UBOOT_IMG=$IMAGES_DIR/u-boot.bin
UBOOT_ENV=$IMAGES_DIR/uboot-env.bin

export LC_ALL=C

if [ $# -ne 1 ]; then
	echo "Usage: $0 <images_dir>"
	exit 1;
fi

if [ ! -f $UBOOT_IMG ] ||
   [ ! -f $UBOOT_ENV ] ||
   [ ! -f $ROOTFS ]; then
	echo "Missing u-boot or rootfs"
	exit 1
fi

rm -f $OUTPUT
rm -f $OUTPUT_XFSTK

# Create a raw image of the contents of the EMMC
# The u-boot binary offset is hardcoded in $OSIP.
# The u-boot environment offsets are hardcoded in
# u-boot's edison configuration.
# The rootfs offset is hardcoded in $OSIP
# The total size of the image is hardcoded in $OSIP.
#   NOTE: The total image size can be adjusted down so
#         that less Flash needs to be read each boot,
#         but it seems like xfstk reads it rather than
#         looking at the file length.
dd if=$OSIP of=$OUTPUT 2>/dev/null
dd if=$UBOOT_IMG of=$OUTPUT seek=2056 2>/dev/null
dd if=$UBOOT_ENV of=$OUTPUT seek=6144 2>/dev/null
dd if=$UBOOT_ENV of=$OUTPUT seek=12288 2>/dev/null
dd if=$ROOTFS of=$OUTPUT seek=14336 2>/dev/null

# Intel's XFSTK tool reads the OSIP header to
# determine where to write the bytes immediately following
# the block, so they need to be removed for the tool to work.
dd if=$OSIP of=$OUTPUT_XFSTK 2>/dev/null
dd if=$OUTPUT of=$OUTPUT_XFSTK skip=2048 seek=1 2>/dev/null
