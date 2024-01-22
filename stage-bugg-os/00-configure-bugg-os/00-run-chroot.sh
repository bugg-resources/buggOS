#!/bin/bash -e
echo "  🔧 Running steps within chroot environment"
echo "    ⚙️ Enable I2C"
raspi-config nonint do_i2c 0 || echo "raspi-config: Error enabling I2C"
echo "  🍻 Success!"
