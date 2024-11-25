# Introduction
buggOS is a modified version of Raspberry Pi OS for the Bugg v3 bioacoustics recorder. It is designed to be loaded onto a Raspberry Pi CM4 on the Bugg mainboard and run potentially with no internet connection, so it packages everything that the Bugg project needs with no dependencies from the internet.

Like Raspberry Pi OS itself, buggOS is built using [pi-gen](https://github.com/RPi-Distro/pi-gen).

buggOS packages various dependencies including buggd - the Bugg application firmware and the Bugg soundcard driver kernel module.

# Building
buggOS is built with a Github Actions workflow defined in ``.github/workflows/release.yml``. It defines a pipeline with two jobs - ``build`` and ``release``. ``build`` runs the pi-gen build, resulting in an OS image artefact. ``release`` applies a filename with a version number, and uploads the artefact out of the runner to the buggOS github repo as a release downloadable by humans.pi-gen can only run on a Debian-based distro, so an Ubuntu runner was used.

To run the build, [go here](https://github.com/bugg-resources/buggOS/actions/workflows/release.yml) and click on the Run Workflow button.

## Build server
 During development, an ARM64 Ubuntu AWS instance was used as a build server. This produced a major performance improvement over Github Actions as the build runs much faster on ARM64. Github will soon launch ARM64 runners, but at present they are only available in beta. Disk bandwidth was the major bottleneck limiting build speed. In future development, consider configuring a build server to use RAM as storage for the build image.

On the build server, ``act`` is used to run the Github Action locally. It is configured with the ``.actrc`` file. To run the build, run ``build_normal.sh``. 

# Version numbering
buggd is versioned according to the [SemVer standard](https://semver.org). The version is set in a git tag in the main branch.

# Updating to a new release of Raspberry Pi OS
When there is a new release of Raspberry Pi OS, edit the ``RELEASE=`` string in ``config`` and set the ``ref:`` string in the pi-gen checkout step (line 50 of ``release.yml``) to select the desired release tag from the pi-gen repo.

# Adding dependency packages
To add APT packages to the build, add them to the ``00-packages`` file.

# Deploying to a Bugg device
A Linux machine is required for this process.

1) Download the release from Github. NOTE: remember to unzip with ``gunzip``
2) Connect a micro-USB cable to the Bugg's bootloader port. Plug into your computer.
3) Connect a USB-to-M12 cable to the Bugg's M12 connector. Plug into your computer.
4) Compile the rpiboot tool from the [usbboot repo](https://github.com/raspberrypi/usbboot)
5) Use the mass-storage-gadget64 mode as follows:
```
cd mass-storage-gadget64
../rpiboot -d .
```
6) Now the CM4 should be accessible as a block device like ``/dev/sda``. Check with ``lsblk``. Note that it may take a few seconds for the block device to appear.
7) Given an image named, e.g., ``Adze_1.0.9-2-gc675b7b-lite.img``, flash the device with ``sudo dd bs=10M of=/dev/sda if=Adze_1.0.9-2-gc675b7b-lite.img``. WARNING: make absolutely certain you supply the correct block device or you could damage your system.
