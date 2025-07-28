#!/bin/bash

west init --mr v4.2.0 zephyrproject
cd zephyrproject
west update

# Add logging functions because error 'AttributeError: 'Blobs' object has no attribute 'dbg'' (for example) is received
sed -i '/^class /a\ \ \ \ def dbg(self, msg):\n\ \ \ \ \ \ \ \ print(msg)' /zephyrproject/zephyr/scripts/west_commands/blobs.py 
sed -i '/^class /a\ \ \ \ def inf(self, msg):\n\ \ \ \ \ \ \ \ print(msg)' /zephyrproject/zephyr/scripts/west_commands/blobs.py 
sed -i '/^class /a\ \ \ \ def wrn(self, msg):\n\ \ \ \ \ \ \ \ print(msg)' /zephyrproject/zephyr/scripts/west_commands/blobs.py 
sed -i '/^class /a\ \ \ \ def err(self, msg):\n\ \ \ \ \ \ \ \ print(msg)' /zephyrproject/zephyr/scripts/west_commands/blobs.py 
west blobs fetch hal_espressif
west blobs fetch hal_stm32

find . -name \.git|xargs rm -rf

cd ..
mkdir -p /artifacts/pip/requirements1
cp ./zephyrproject/zephyr/scripts/requirements* /artifacts/pip/requirements1/
mkdir -p /artifacts/pip/requirements2
cp ./zephyrproject/bootloader/mcuboot/scripts/requirements* /artifacts/pip/requirements2/

tar -cf - zephyrproject/ -P | pv -s $(du -sb zephyrproject/ | awk '{print $1}') | bzip2 -c > /artifacts/zephyrproject.tar.bz2
