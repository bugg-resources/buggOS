#!/bin/bash -e
# -e flag causes the script to exit if any command returns a non-zero exit code

# This script is used to install additional files into the rootfs.

echo "🔧 Installing buggd recording daemon"

echo "🔧 Installing bugg-recording Python application package into venv"
on_chroot << EOF
source /opt/venv/bin/activate
pip3 install -e /opt/bugg-recording
EOF

echo "🍻 Success installing bugg-recording"


# The first-boot.service enables this testing service once the system is fully configured
echo "⚙️ Install buggd.service"
install -m 644 buggd.service "${ROOTFS_DIR}/etc/systemd/system/"

echo "🍻 Success installing first boot service!"