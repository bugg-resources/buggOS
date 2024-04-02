#!/bin/bash -e

echo "🪲 Bugg-OS Configuration Begins!"

if [ ! -d "${ROOTFS_DIR}" ]; then
	copy_previous
fi
