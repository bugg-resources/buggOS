#!/bin/bash -e
# -e flag causes the script to exit if any command returns a non-zero exit code

echo "---> Enable UART console"
echo "enable_uart=1" >> ${ROOTFS_DIR}/boot/config.txt
sed -i "s/ quiet//g" ${ROOTFS_DIR}/boot/cmdline.txt

echo "---> Enable USB OTG"
echo "dtoverlay=dwc2,dr_mode=host" >> ${ROOTFS_DIR}/boot/config.txt
echo "otg_mode=1" >> ${ROOTFS_DIR}/boot/config.txt

echo "---> Disable Bluetooth"
echo "dtoverlay=disable-bt" >> ${ROOTFS_DIR}/boot/config.txt

echo "---> Enable Hardware Watchdog"
echo "dtparam=watchdog=on" >> ${ROOTFS_DIR}/boot/config.txt

echo "---> Install Bugg Recording Userspace"
# bugg-cm4-firmware has already been cloned by the workflow script
cp -r bugg-cm4-firmware ${ROOTFS_DIR}/home/${FIRST_USER_NAME}

echo "---> Enable DS2331 RTC"
echo "dtoverlay=i2c-rtc,ds3231,wakeup-source" >> ${ROOTFS_DIR}/boot/config.txt

echo ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/bees.txt
echo "hello" > ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/bees.txt
