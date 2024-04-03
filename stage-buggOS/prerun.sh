#!/bin/bash -e

echo "🪲 buggOS Configuration Begins!"

if [ ! -d "${ROOTFS_DIR}" ]; then
	copy_previous
fi
