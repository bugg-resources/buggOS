#!/bin/bash -e
# -e flag causes the script to exit if any command returns a non-zero exit code

echo "Running stage-bugg-os/00-configure-bugg-os/00-run.sh"
echo "  🔧 Configuring the Raspberry Pi Hardware"

echo "    ⚙️ Enable Verbose Boot Messages"
sed -i "s/ quiet//g" ${ROOTFS_DIR}/boot/firmware/cmdline.txt

echo "    ⚙️ Enable USB OTG"
echo "dtoverlay=dwc2,dr_mode=host" >> ${ROOTFS_DIR}/boot/firmware/config.txt
echo "otg_mode=1" >> ${ROOTFS_DIR}/boot/firmware/config.txt

echo "    ⚙️ Disable Bluetooth"
echo "dtoverlay=disable-bt" >> ${ROOTFS_DIR}/boot/firmware/config.txt

echo "    ⚙️ Enable Hardware Watchdog"
echo "dtparam=watchdog=on" >> ${ROOTFS_DIR}/boot/firmware/config.txt

echo "    ⚙️ Enable DS2331 RTC"
echo "dtoverlay=i2c-rtc,ds3231,wakeup-source" >> ${ROOTFS_DIR}/boot/firmware/config.txt

echo "    ⚙️ Enable hardware watchdog"
echo "dtparam=watchdog=on" >> ${ROOTFS_DIR}/boot/firmware/config.txt
echo "watchdog-device=/dev/watchdog" >> ${ROOTFS_DIR}/etc/watchdog.conf
echo "watchdog-timeout=15" >> ${ROOTFS_DIR}/etc/watchdog.conf
echo "max-load-1 = 24" >> ${ROOTFS_DIR}/etc/watchdog.conf


echo "    ⚙️ Enable I2C"
on_chroot << EOF
SUDO_USER="${FIRST_USER_NAME}" raspi-config nonint do_i2c 0
EOF

echo "    ⚙️ Enable Auto Login"     # TODO: This doesn't work
on_chroot << EOF
SUDO_USER="${FIRST_USER_NAME}" raspi-config nonint do_boot_behaviour B2
EOF

echo "    ⚙️ Enable the serial port"
on_chroot << EOF
SUDO_USER="${FIRST_USER_NAME}" raspi-config nonint do_serial_hw 0
EOF

echo "    ⚙️ Enable remote GPIO access"
on_chroot << EOF
SUDO_USER="${FIRST_USER_NAME}" raspi-config nonint do_rgpio 0
EOF

echo "    ⚙️ Set Timezone to UTC"
on_chroot << EOF
SUDO_USER="${FIRST_USER_NAME}" raspi-config nonint do_change_timezone UTC
EOF

echo "  🍻 Finished configuring hardware!"


#echo ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/bees.txt
# echo "hello" > ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/bees.txt
