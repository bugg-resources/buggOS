#!/bin/bash -e
# -e flag causes the script to exit if any command returns a non-zero exit code

# This script installs the Python application firmware package into a venv.

# The package's dependencies are defined in the package so they are automatically installed. 

# We use a venv because RPi OS prevents system-wide installation of Python packages with PIP.
# (it is an Externally Managed Environment)

echo "🔧 Configuring venv"
on_chroot << EOF
python3 -m venv --system-site-packages /opt/venv
EOF

echo "🔧 Installing bugg-recording Python application package into venv"
on_chroot << EOF
source /opt/venv/bin/activate
pip3 install -e /opt/bugg-recording
EOF

echo "🍻 Success installing bugg-recording"