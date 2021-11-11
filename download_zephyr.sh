#!/bin/bash

west init zephyrproject
cd zephyrproject
west update 
find . -name \.git|xargs rm -rf
cd ..
mkdir -p /artifacts/pip/requirements1
cp ./zephyrproject/zephyr/scripts/requirements* /artifacts/pip/requirements1/

mkdir -p /artifacts/pip/requirements2
cp ./zephyrproject/bootloader/mcuboot/scripts/requirements* /artifacts/pip/requirements2/

tar -cf - zephyrproject/ -P | pv -s $(du -sb zephyrproject/ | awk '{print $1}') | bzip2 -c > /artifacts/zephyrproject.tar.bz2
