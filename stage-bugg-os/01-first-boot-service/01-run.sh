#!/bin/bash -e
# -e flag causes the script to exit if any command returns a non-zero exit code

# This script is used to install additional files into the rootfs.

echo "🔧 Installing additional files"


# The first-boot.service systemd service will run this script once, on first boot.
echo "    ⚙️ Install first-boot.service"
install -m 644 first-boot.service "${ROOTFS_DIR}/etc/systemd/system/"
install -m 755 first-boot.sh "${ROOTFS_DIR}/usr/local/bin/"

echo "  🍻 Success installing first boot service!"