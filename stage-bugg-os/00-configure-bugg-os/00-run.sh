#!/bin/bash -e
# -e flag causes the script to exit if any command returns a non-zero exit code

echo "hello" > ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/bees.txt
