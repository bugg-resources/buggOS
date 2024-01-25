#!/bin/bash -e

# This script runs once, on first boot.
# It is run by the first-boot.service systemd service.
# Debug statements are logged to the journal.
# To view the journal, run `journalctl -u first-boot.service -f`

logger -t first-boot.sh "🔧 Bugg-OS First Boot Script"
touch /opt/first-boot.sh-ran

logger "⚙️ Enable I2C"
raspi-config nonint do_i2c 0

# logger "⚙️ Enable Auto Login"
# raspi-config nonint do_boot_behaviour B2

logger "⚙️ Enable the serial port"
raspi-config nonint do_serial_hw 0

logger "⚙️ Enable remote GPIO access"
raspi-config nonint do_rgpio 0

logger "⚙️ Set Timezone to UTC"
raspi-config nonint do_change_timezone UTC

logger "⚙️ Start the watchdog service"
systemctl enable watchdog
systemctl start watchdog 
systemctl status watchdog

logger "⚙️ Disabling first-boot.service"
#systemctl stop first-boot.service
systemctl disable first-boot.service

logger -t first-boot.sh "🍻 First boot script complete."
