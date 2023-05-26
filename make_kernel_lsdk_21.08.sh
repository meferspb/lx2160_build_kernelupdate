#!/bin/bash
echo "Make Linux kernel on lx2160 with all patches from SolidRun lx2160_build"
echo "RUN Only on board solidrun lx2160"
pause 10

apt update && apt update
apt install make libncurses-dev libncurses dwarves build-essential gcc bc bison flex libssl-dev libelf-dev
ROOTDIR=`pwd`

mkdir -p $ROOTDIR/build
if [[ ! -d $ROOTDIR/build/linux ]]; then
        cd $ROOTDIR/build
        git clone --depth 1 https://github.com/nxp-qoriq/linux -b LSDK-21.08
        cd $ROOTDIR/build/linux
        ./scripts/kconfig/merge_config.sh arch/arm64/configs/defconfig arch/arm64/configs/lsdk.config $ROOTDIR/configs/linux/lx2k_additions.config
        git am $ROOTDIR/patches/linux-LSDK-21.08/*.patch
fi

cd $ROOTDIR/build/linux
make -j`nproc` all
make -j`nproc` bindeb-pkg

cp $ROOTDIR/build/linux/arch/arm64/boot/Image $ROOTDIR/build

