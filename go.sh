# This script can be run manually, as an alternative to running the build  in a CI pipeline

# Copy current build files into /pi-gen
cp config pi-gen/config
cp -R stage-bugg-os pi-gen

# Run the build
cd pi-gen
/home/ubuntu/shellprof/shellprof ./build.sh
cd -



