git pull \
&& sudo find deploy/ -type f -delete;\
time sudo /home/ubuntu/bin/act -j image-builder  -s GITHUB_TOKEN=`cat /home/ubuntu/github_token` \
&& sudo ./copy_img_to_host.sh

