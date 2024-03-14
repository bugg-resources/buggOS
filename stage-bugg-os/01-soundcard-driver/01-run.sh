#!/bin/bash -e
# -e flag causes the script to exit if any command returns a non-zero exit code

echo "🔧 Installing Bugg soundcard driver"
mkdir -p "${ROOTFS_DIR}/opt"
cp -r "${STAGE_DIR}/files/bugg-soundcard-driver" "${ROOTFS_DIR}/opt/"
