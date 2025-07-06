#!/usr/bin/env bash
TOOLCHAINS="$(realpath $(dirname $0)/../../toolchain)"
export PATH="$TOOLCHAINS/Snapdragon-LLVM-ARM-Compiler-10.0.7-for-Android-NDK/bin:$PATH"
export PATH="$TOOLCHAINS/aarch64-linux-android-4.9/bin:$PATH"
export LD_LIBRARY_PATH="$TOOLCHAINS/Snapdragon-LLVM-ARM-Compiler-10.0.7-for-Android-NDK/lib64"
FLAGS=$(echo ARCH=arm64 O="$(realpath $(dirname $0)/../../Xiaomi_Kernel_OpenSource/out)" CC=clang HOSTCC=gcc HOSTCXX=g++ CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE=aarch64-linux-android-)

MAKE="make $FLAGS" \
KERNEL_SRC="$(realpath $(dirname $0)/../../Xiaomi_Kernel_OpenSource)" \
INSTALL_MOD_PATH="$(realpath $(dirname $0)/../../sysroot)" \
KBUILD_EXTRA=" \
WLAN_PROFILE=default \
CONFIG_CNSS_QCA6390=y \
DYNAMIC_SINGLE_CHIP=qca6390 \
" \
make $FLAGS "$@"
