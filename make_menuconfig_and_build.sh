#!/bin/bash
echo "Make Linux kernel on lx2160 with menuconfig"
echo "RUN Only on board solidrun lx2160"
pause 10

ROOTDIR=`pwd`


cd $ROOTDIR/build/linux
make menuconfig
make -j`nproc` all
make -j`nproc` bindeb-pkg

cp $ROOTDIR/build/linux/arch/arm64/boot/Image $ROOTDIR/build
