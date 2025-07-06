#!/usr/bin/env bash
TOOLCHAINS=$(realpath $(dirname $0)/../toolchain)
export PATH="$TOOLCHAINS/Snapdragon-LLVM-ARM-Compiler-10.0.7-for-Android-NDK/bin:$PATH"
export PATH="$TOOLCHAINS/aarch64-linux-android-4.9/bin:$PATH"
export LD_LIBRARY_PATH="$TOOLCHAINS/Snapdragon-LLVM-ARM-Compiler-10.0.7-for-Android-NDK/lib64"

OS="13.0.0"
OS_PATCH_LEVEL="2023-10"
KDIR=$(readlink -f $(dirname $0))
RESOURCE=$(readlink -f $(realpath $(dirname $0)/../mkbootimg_resource))
OUT=$(readlink -f $KDIR/out)

FLAGS=$(echo ARCH=arm64 O="$OUT" CC=clang HOSTCC=gcc HOSTCXX=g++ CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE=aarch64-linux-android-)

# build boot.img and vendor_boot.img
if [[ "$1" == "bootimg" ]]; then
	python3 $TOOLCHAINS/mkbootimg/mkbootimg.py \
		--header_version 3 \
		--os_version $OS \
		--os_patch_level $OS_PATCH_LEVEL \
		--cmdline '' \
		--kernel $OUT/arch/arm64/boot/Image \
		--ramdisk $RESOURCE/ramdisk \
		-o $OUT/boot.img
	python3 $TOOLCHAINS/mkbootimg/mkbootimg.py \
		--header_version 3 \
		--pagesize 0x00001000 \
		--base 0x00000000 \
		--kernel_offset 0x00008000 \
		--ramdisk_offset 0x01000000 \
		--tags_offset 0x00000100 \
		--dtb_offset 0x0000000001f00000 \
		--vendor_cmdline 'console=ttyMSM0,115200n8 androidboot.hardware=qcom androidboot.console=ttyMSM0 androidboot.memcg=1 lpm_levels.sleep_disabled=1 video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 service_locator.enable=1 androidboot.usbcontroller=a600000.dwc3 swiotlb=2048 loop.max_part=7 cgroup.memory=nokmem,nosocket reboot=panic_warm cnss2.disable_nv_mac=1 buildvariant=user' \
		--board '' \
		--vendor_boot $OUT/vendor_boot.img \
		--vendor_ramdisk $RESOURCE/vendor_ramdisk \
		--dtb $OUT/arch/arm64/boot/dtb
	exit
fi

# passthrough arguments to build kernel
make $FLAGS "$@"

