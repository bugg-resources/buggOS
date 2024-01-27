#!/bin/bash -e
# -e flag causes the script to exit if any command returns a non-zero exit code

# This script installs the Python dependencies for the application software.
# The bugg-recording repo is cloned into files/bugg-recording by the GA workflow.

mkdir -p "${ROOTFS_DIR}/opt"
cp -r "${STAGE_DIR}/files/bugg-recording" "${ROOTFS_DIR}/opt/"
