#!/bin/bash -e
# -e flag causes the script to exit if any command returns a non-zero exit code

# This script builds and installs the Bugg soundcard driver kernel module.


echo "🔧 Installing Bugg soundcard driver"
mkdir -p "${ROOTFS_DIR}/opt"
cp -r "${STAGE_DIR}/files/bugg-soundcard-driver" "${ROOTFS_DIR}/opt/"

# on_chroot << EOF
# cd /opt/bugg-soundcard-driver/codec
# make
# make install

cd /opt/bugg-soundcard-driver/dt
make
make install
EOF