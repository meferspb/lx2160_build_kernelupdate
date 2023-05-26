#!/bin/bash
echo "Install new kernel on device"
pause 10

ROOTDIR=`pwd`
cp /boot/Image /boot/Image_bak
cp $ROOTDIR/build/Image /boot/Image

cd $ROOTDIR/build
dpkg -i linux-*.deb

pause 60
