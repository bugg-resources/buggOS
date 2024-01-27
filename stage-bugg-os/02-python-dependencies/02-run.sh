#!/bin/bash -e
# -e flag causes the script to exit if any command returns a non-zero exit code

# This script installs the Python dependencies for the application firmware.

# Currently this takes a list of dependencies from the local requirements.txt file.
# In the future, we should pull in the dependencies from the application firmware repo.

on_chroot << EOF
echo "  🔧 Installing Python dependencies"

echo "    ⚙️ Install Python dependencies"
pip3 install -r requirements.txt
EOF