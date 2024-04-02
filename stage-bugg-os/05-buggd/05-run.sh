#!/bin/bash -e
# -e flag causes the script to exit if any command returns a non-zero exit code

# First we create a virtual environment (venv) to install the buggd package into.
# Then we install the buggd Python package into the venv.
# buggd's Python dependencies are defined in the package so they are automatically installed. 

# We install the buggd python package direct from github so that we can easily update it.

# We use a venv because RPi OS prevents system-wide installation of Python packages with PIP.
# (it is an Externally Managed Environment)

echo "🔧 Configuring venv"
on_chroot << EOF
python3 -m venv --system-site-packages /opt/venv
EOF

echo "🔧 Installing bugg-recording Python application package into venv"
on_chroot << EOF
source /opt/venv/bin/activate
pip3 install -e git+https://github.com/jeffmakes/buggd.git
EOF

echo "🍻 Success installing buggd package!"

# The first-boot.service enables this testing service once the system is fully configured
# During initial setup the system reboots multiple times
echo "⚙️ Install buggd.service"
install -m 644 buggd.service "${ROOTFS_DIR}/etc/systemd/system/"

echo "🍻 Success installing buggd service!"