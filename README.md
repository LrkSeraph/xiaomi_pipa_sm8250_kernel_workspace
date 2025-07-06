# xiaomi_pipa_sm8250_kernel_workspace
This repository contains all required file to build kernel for Xiaomi Pad 6(pipa). <br/>
It also contains build script for wlan driver. <br/>

# How to use
You need to sync the submodule and enter `Xiaomi_Kernel_OpenSource` directory. <br/>
Then run
```bash
mkdir out
cp ../config-stable out/.config
bash build.sh -j$(nproc) && bash build.sh bootimg
```
After the build complete, you will see `out/boot.img` and `out/vendor_boot.img`. <br/>
Then run `flash.sh` to flash `boot`, `vendor_boot` and `dtbo` to your device.
