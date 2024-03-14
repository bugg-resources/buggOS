#!/bin/bash -e

# This script runs on first boot.
# It is run by the first-boot.service systemd service.
# Debug statements are logged to the journal.
# To view the journal, run `journalctl -u first-boot.service -f`


RAN_FLAG="/opt/.first-boot.sh-ran"   

logger -t first-boot.sh "🔧 Bugg-OS First Boot Script"

echo "Ran at `date`" >> $RAN_FLAG

logger -t first-boot.sh "🍻 First boot script complete."
