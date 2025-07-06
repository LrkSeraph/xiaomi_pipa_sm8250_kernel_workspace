#!/usr/bin/env bash

fastboot flash boot_a $(dirname $(realpath $0))/Xiaomi_Kernel_OpenSource/out/boot.img && \
fastboot flash vendor_boot_a $(dirname $(realpath $0))/Xiaomi_Kernel_OpenSource/out/vendor_boot.img && \
fastboot flash dtbo_a $(dirname $(realpath $0))/official_image/dtbo.img && \
fastboot set_active a && \
fastboot reboot
