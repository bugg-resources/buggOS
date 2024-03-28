#!/bin/bash -e
# -e flag causes the script to exit if any command returns a non-zero exit code

# This script is used to install additional files into the rootfs.

echo "🔧 Installing buggd recording daemon"


# The first-boot.service enables this testing service once the system is fully configured
echo "⚙️ Install bugg-test.service"
install -m 644 bugg-test.service "${ROOTFS_DIR}/etc/systemd/system/"

echo "🍻 Success installing first boot service!"