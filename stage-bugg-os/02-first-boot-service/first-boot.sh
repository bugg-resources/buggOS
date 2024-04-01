#!/bin/bash -e

# This script runs on first boot.
# It is run by the first-boot.service systemd service.
# Debug statements are logged to the journal.
# To view the journal, run `journalctl -u first-boot.service -f`


logger -t first-boot.sh "🔧 Bugg-OS First Boot Script"

RAN_FLAG="/opt/.first-boot.sh-ran"   
echo "Ran at `date`" >> $RAN_FLAG

# By the time this script runs, the root filesystem has been expanded to fill the SD card,
# the system had rebooted once, and the first-boot.service has run, installing the Bugg soundcard driver.
# Now we enable the testing service, disable the first-boot service, and reboot the system so the soundcard driver can load.
logger -t first-boot.sh "⚙️ Enabling the bugg-test service"
systemctl enable buggd.service

logger -t first-boot.sh "⚙️ Disabling first-boot.service"
systemctl disable first-boot.service

logger -t first-boot.sh "🍻 First boot script complete - rebooting the system"
reboot
