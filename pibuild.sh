git clone https://github.com/RPi-Distro/pi-gen.git
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install coreutils quilt parted qemu-user-static debootstrap zerofree zip \
dosfstools libarchive-tools libcap2-bin grep rsync xz-utils file git curl bc \
qemu-utils kpartx gpg pigz

touch pi-gen/stage3/SKIP
touch pi-gen/stage4/SKIP
touch pi-gen/stage5/SKIP
touch pi-gen/stage4/SKIP_IMAGES
touch pi-gen/stage5/SKIP_IMAGES
cp config pi-gen/config
cd pi-gen
sudo ./build.sh