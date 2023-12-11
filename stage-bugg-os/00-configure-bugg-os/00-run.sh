#!/bin/bash -e
# -e flag causes the script to exit if any command returns a non-zero exit code

echo "---> Enable UART console"
echo "enable_uart=1" >> ${ROOTFS_DIR}/boot/config.txt
sed -i "s/ quiet//g" ${ROOTFS_DIR}/boot/cmdline.txt

echo "---> Install Bugg Recording Userspace"
# bugg-cm4-firmware has already been cloned by the workflow script
install --owner=${FIRST_USER_NAME} --group=${FIRST_USER_NAME} bugg-cm4-firmware ${ROOTFS_DIR}/home/${FIRST_USER_NAME}

echo ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/bees.txt
echo "hello" > ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/bees.txt
