#!/bin/bash -e
# -e flag causes the script to exit if any command returns a non-zero exit code

echo "Running stage-bugg-os/00-configure-bugg-os/00-run.sh"
echo "🪲 Bugg-OS Configuration Begins!"
echo "  🔧 Configuring the Raspberry Pi"

echo "    ⚙️ Enable UART console"
echo "enable_uart=1" >> ${ROOTFS_DIR}/boot/firmware/config.txt
sed -i "s/ quiet//g" ${ROOTFS_DIR}/boot/firmware/cmdline.txt

echo "    ⚙️ Enable USB OTG"
echo "dtoverlay=dwc2,dr_mode=host" >> ${ROOTFS_DIR}/boot/firmware/config.txt
echo "otg_mode=1" >> ${ROOTFS_DIR}/boot/firmware/config.txt

echo "    ⚙️ Disable Bluetooth"
echo "dtoverlay=disable-bt" >> ${ROOTFS_DIR}/boot/firmware/config.txt

echo "    ⚙️ Enable Hardware Watchdog"
echo "dtparam=watchdog=on" >> ${ROOTFS_DIR}/boot/firmware/config.txt

echo "    ⚙️ Install Bugg Recording Userspace"
# bugg-cm4-firmware has already been cloned by the workflow script
cp -r files/bugg-cm4-firmware ${ROOTFS_DIR}/home/${FIRST_USER_NAME}

echo "    ⚙️ Enable DS2331 RTC"
echo "dtoverlay=i2c-rtc,ds3231,wakeup-source" >> ${ROOTFS_DIR}/boot/firmware/config.txt

echo "    ⚙️ Enable hardware watchdog"
echo "dtparam=watchdog=on" >> ${ROOTFS_DIR}/boot/firmware/config.txt
echo "watchdog-device=/dev/watchdog" >> ${ROOTFS_DIR}/etc/watchdog.conf
echo "watchdog-timeout=15" >> ${ROOTFS_DIR}/etc/watchdog.conf
echo "max-load-1 = 24" >> ${ROOTFS_DIR}/etc/watchdog.conf

#echo ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/bees.txt
# echo "hello" > ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/bees.txt
