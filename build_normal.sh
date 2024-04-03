RUNNER="roadrunner" # This is the name of my runner on Github. With -P act replaces it with the local

git pull \
&& sudo find deploy/ -type f -delete;\
time sudo /home/ubuntu/bin/act --bind -P {$RUNNER}=ubuntu-latest -j build  -s GITHUB_TOKEN=`cat /home/ubuntu/github_token` \

