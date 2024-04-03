git pull \
&& sudo find deploy/ -type f -delete;\
time sudo /home/ubuntu/bin/act --bind -P -j build  -s GITHUB_TOKEN=`cat /home/ubuntu/github_token` \

