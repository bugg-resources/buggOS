#!/bin/bash -e

# This script runs on first boot.
# It is run by the first-boot.service systemd service.
# Debug statements are logged to the journal.
# To view the journal, run `journalctl -u first-boot.service -f`

# Because Raspberry Pi OS does a load of weird stuff on forst boot, 
# like expanding the filesystem, this script is run after the "true"
# first boot as well, until it is certain that it has run once on a stable footing.
# This is done by creating a flag file in /opt/.first-boot.sh-ran
# The flag remains even after the service is disabled, so it will
# be available for debugging purposes

RAN_FLAG="/opt/.first-boot.sh-ran"   

if [ -f $RAN_FLAG ]; then
    logger "🚩 RAN flag found. Disable service."
    systemctl disable first-boot.service
else
    logger "👀 RAN flag does not exist - create it."
    echo "Ran at `date`" >> $RAN_FLAG
fi

logger -t first-boot.sh "🔧 Bugg-OS First Boot Script"

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
# systemctl disable first-boot.service

logger -t first-boot.sh "🍻 First boot script complete."
