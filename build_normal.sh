git pull \
&& sudo find deploy/ -type f -delete;\
time sudo /home/ubuntu/bin/act -j image-builder  -s GITHUB_TOKEN=`cat /home/ubuntu/github_token` -b /home/ubuntu/buggOS/deploy:/home/ubuntu/buggOS/pi-gen/deploy \
--artifact-server-path /home/ubuntu/buggOS/artifact \
&& sudo ./copy_img_to_host.sh

