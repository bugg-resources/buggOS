#!/bin/bash -e
# -e flag causes the script to exit if any command returns a non-zero exit code

echo "Running stage-bugg-os/00-configure-bugg-os/00-run.sh"
echo "🔧 Configuring the Raspberry Pi Hardware"

echo "⚙️ Enable Verbose Boot Messages"
sed -i "s/ quiet//g" ${ROOTFS_DIR}/boot/firmware/cmdline.txt

echo "⚙️ Disable Bluetooth"
echo "dtoverlay=disable-bt" >> ${ROOTFS_DIR}/boot/firmware/config.txt

echo "⚙️ Enable Hardware Watchdog"
echo "dtparam=watchdog=on" >> ${ROOTFS_DIR}/boot/firmware/config.txt

echo "⚙️ Enable DS2331 RTC"
echo "dtoverlay=i2c-rtc,ds3231,wakeup-source" >> ${ROOTFS_DIR}/boot/firmware/config.txt

echo "⚙️ Enable hardware watchdog"
echo "dtparam=watchdog=on" >> ${ROOTFS_DIR}/boot/firmware/config.txt
echo "watchdog-device=/dev/watchdog" >> ${ROOTFS_DIR}/etc/watchdog.conf
echo "watchdog-timeout=15" >> ${ROOTFS_DIR}/etc/watchdog.conf
echo "max-load-1 = 24" >> ${ROOTFS_DIR}/etc/watchdog.conf

echo "⚙️ Disable I2C on ID_SC and ID_SD pins"
echo "force_eeprom_read=0" >> ${ROOTFS_DIR}/boot/firmware/config.txt

echo "⚙️ Enable the SD card bus via the SDHOST interface"
dtc -@ -I dts -O dtb -o ${ROOTFS_DIR}/boot/overlays/sd0.dtbo ${STAGE_DIR}/files/sd0-overlay.dts
echo "dtoverlay=sd0,overclock_50=50" >> ${ROOTFS_DIR}/boot/firmware/config.txt

echo "⚙️ Enable Auto Login" # TODO: This doesn't work
on_chroot << EOF
SUDO_USER="${FIRST_USER_NAME}" raspi-config nonint do_boot_behaviour B2
EOF

echo "⚙️ Enable I2C"
on_chroot << EOF
SUDO_USER="${FIRST_USER_NAME}" raspi-config nonint do_i2c 0
EOF

echo "⚙️ Enable SPI"
on_chroot << EOF
SUDO_USER="${FIRST_USER_NAME}" raspi-config nonint do_spi 0
EOF

echo "⚙️ Enable the serial port"
on_chroot << EOF
SUDO_USER="${FIRST_USER_NAME}" raspi-config nonint do_serial_hw 0
EOF

echo "⚙️ Enable remote GPIO access"
on_chroot << EOF
SUDO_USER="${FIRST_USER_NAME}" raspi-config nonint do_rgpio 0
EOF

echo "⚙️ Set Timezone to UTC"
on_chroot << EOF
SUDO_USER="${FIRST_USER_NAME}" raspi-config nonint do_change_timezone UTC
EOF

echo "🍻 Finished configuring hardware!"

echo "⚙️ Auto-resize serial TTY to fill the terminal emulator window on login"
echo "resize" > ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.bash_profile
