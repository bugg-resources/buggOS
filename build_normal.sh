git pull \
&& sudo find deploy/ -type f -delete;\
time sudo /home/ubuntu/bin/act --bind \
--artifact-server-path /tmp/artifacts \
-j release \
-s GITHUB_TOKEN=`cat /home/ubuntu/github_token` \
