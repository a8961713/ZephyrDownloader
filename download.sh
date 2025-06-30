#!/bin/bash

dist=$1
PIP3_PACKAGES_DIR=pip3_packages_${dist}

mkdir -p ${PIP3_PACKAGES_DIR}
cd ${PIP3_PACKAGES_DIR}

pip3 download -d . pip
python3 -m pip install --upgrade pip
pip3 download -d . -r /artifacts/pip/requirements1/requirements.txt
pip3 download -d . -r /artifacts/pip/requirements2/requirements.txt
pip3 download -d . poetry-core

cd ..

tar -cf - ${PIP3_PACKAGES_DIR}/ -P | pv -s $(du -sb ${PIP3_PACKAGES_DIR}/ | awk '{print $1}') | bzip2 -c > /artifacts/${PIP3_PACKAGES_DIR}.tar.bz2
