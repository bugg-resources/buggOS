#!/bin/bash

# This script runs once, on first boot.
# It is run by the first-boot.service systemd service.
echo "🔧 Bugg-OS First Boot"

echo "    ⚙️ Enable I2C"
raspi-config nonint do_i2c 0 || echo "raspi-config: Error enabling I2C"

echo "    ⚙️ Enable Auto Login"
raspi-config nonint do_boot_behaviour B2 || echo "raspi-config: Error enabling Auto Login"

echo "    ⚙️ Enable the serial port"
raspi-config nonint do_serial_hw 0 || echo "raspi-config: Error enabling the serial port"

echo "    ⚙️ Enable remote GPIO access"
raspi-config nonint do_rgpio 0 || echo "raspi-config: Error enabling remote GPIO access"

echo "    ⚙️ Set Timezone to UTC"
raspi-config nonint do_change_timezone UTC || echo "raspi-config: Error setting timezone" 



# If everything finisihses successfully, the first-boot.service will be disabled
systemctl stop first-boot.service
systemctl disable first-boot.service
