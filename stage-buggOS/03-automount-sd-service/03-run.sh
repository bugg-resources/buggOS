#!/bin/bash -e
# -e flag causes the script to exit if any command returns a non-zero exit code

# This script is used to install additional files into the rootfs.

echo "🔧 Installing SD card auto-mount service"


# These servies auto-mount the SD card to /mnt/sd
echo "⚙️ Install SD auto-mount service"
install -m 644 mnt-sd.automount "${ROOTFS_DIR}/etc/systemd/system/"
install -m 644 mnt-sd.mount "${ROOTFS_DIR}/etc/systemd/system/"

# Create symlink to enable mount services
on_chroot << EOF
ln -s /etc/systemd/system/mnt-sd.automount /etc/systemd/system/multi-user.target.wants/mnt-sd.automount
ln -s /etc/systemd/system/mnt-sd.mount /etc/systemd/system/multi-user.target.wants/mnt-sd.mount
EOF

echo "🍻 Success installing SD auto-mount service!"
