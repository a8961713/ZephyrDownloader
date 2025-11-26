#!/bin/bash

dist=$1
PIP3_PACKAGES_DIR=pip3_packages_${dist}

mkdir -p ${PIP3_PACKAGES_DIR}
cd ${PIP3_PACKAGES_DIR}

pip3 download -d . pip
# No need to upgrade pip as this was done when the docker was built
pip3 download -d . -r /artifacts/pip/requirements1/requirements.txt
pip3 download -d . -r /artifacts/pip/requirements2/requirements.txt
pip3 download -d . -r /artifacts/pip/requirements3/requirements.txt
pip3 download -d . poetry-core
# esptool is downloaded as a tar.gz; This creates a wheel file
pip3 wheel esptool

cd ..

tar -cf - ${PIP3_PACKAGES_DIR}/ -P | pv -s $(du -sb ${PIP3_PACKAGES_DIR}/ | awk '{print $1}') | bzip2 -c > /artifacts/${PIP3_PACKAGES_DIR}.tar.bz2
