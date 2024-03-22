#!/bin/bash -e
# -e flag causes the script to exit if any command returns a non-zero exit code

# This script is used to install additional files into the rootfs.

echo "🔧 Installing udev rules for modem"


# The first-boot.service enables this testing service once the system is fully configured
echo "⚙️ Install udev rules for modem"
install 99-modem.rules "${ROOTFS_DIR}/etc/udev/rules.d/"

echo "🍻 Success installing udev rules for modem"