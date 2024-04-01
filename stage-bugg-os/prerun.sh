#!/bin/bash -e

echo "🪲 Bugg-OS Configuration Begins!"

if [ ! -d "${ROOTFS_DIR}" ]; then
	copy_previous
fi

cp buggd.list ${ROOTFS_DIR}/etc/apt/sources.list.d/buggd.list
apt update