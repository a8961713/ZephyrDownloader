#!/bin/bash

west init zephyrproject
cd zephyrproject
west update 
find . -name \.git|xargs rm -rf
cd ..
tar -cf - zephyrproject/ -P | pv -s $(du -sb zephyrproject/ | awk '{print $1}') | bzip2 -c > /artifacts/zephyrproject.tar.bz2

mkdir pip3_packages
cd pip3_packages

pip3 download -d . -r ../zephyrproject/zephyr/scripts/requirements.txt
pip3 download -d . -r ../zephyrproject/bootloader/mcuboot/scripts/requirements.txt 

cd ..

tar -cf - pip3_packages/ -P | pv -s $(du -sb pip3_packages/ | awk '{print $1}') | bzip2 -c > /artifacts/pip3_packages.tar.bz2

