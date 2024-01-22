#!/bin/bash -e
# -e flag causes the script to exit if any command returns a non-zero exit code

# This script installs PIP and the Python dependencies for Bugg-OS.

echo "  🔧 Installing Python dependencies"

echo "    ⚙️ Install PIP"
apt install -y python3-pip

echo "    ⚙️ Install Python dependencies"
pip3 install -r requirements.txt