#!/bin/bash -e
# -e flag causes the script to exit if any command returns a non-zero exit code

# This script is used to install additional files into the rootfs.

echo "🔧 Installing udev rules for modem"


# These rules ensure the modem's serial ports are always available at fixed paths
# Most importantly, the control port is fixed to /dev/tty_modem_command_interface
echo "⚙️ Install udev rules for modem"
install 99-modem.rules "${ROOTFS_DIR}/etc/udev/rules.d/"

echo "🍻 Success installing udev rules for modem"