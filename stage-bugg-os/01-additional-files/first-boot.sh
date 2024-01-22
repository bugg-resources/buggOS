#!/bin/bash -e

# This script runs once, on first boot.
# It is run by the first-boot.service systemd service.
echo "  🔧 Bugg-OS First Boot"

echo "    ⚙️ Enable I2C"
raspi-config nonint do_i2c 0

echo "    ⚙️ Enable Auto Login"
raspi-config nonint do_boot_behaviour B2

echo "    ⚙️ Enable the serial port"
raspi-config nonint do_serial_hw 0

echo "    ⚙️ Enable remote GPIO access"
raspi-config nonint do_rgpio 0

echo "    ⚙️ Set Timezone to UTC"
raspi-config nonint do_change_timezone UTC

echo "    ⚙️ Start the watchdog service"
systemctl enable watchdog
systemctl start watchdog 
systemctl status watchdog

echo "    ⚙️ Disabling first-boot.service"
systemctl stop first-boot.service
systemctl disable first-boot.service

echo "  🍻 Success!"
