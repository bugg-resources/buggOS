#!/bin/bash -e
# -e flag causes the script to exit if any command returns a non-zero exit code
echo "---> Configuring Bugg OS"
echo ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/bees.txt
echo "hello" > ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/bees.txt
