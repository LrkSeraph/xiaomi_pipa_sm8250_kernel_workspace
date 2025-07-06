#!/usr/bin/env bash
gzip -d -k boot.img.gz
gzip -d -k vendor_boot.img.gz
fastboot flash boot_a boot.img && \
fastboot flash vendor_boot_a vendor_boot.img && \
fastboot flash dtbo_a dtbo.img && \
fastboot set_active a && \
fastboot reboot
rm boot.img vendor_boot.img
