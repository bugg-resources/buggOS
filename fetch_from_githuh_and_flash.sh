url=$1
time curl \
  $url \
|gunzip  | sudo dd bs=10M of=/dev/sda && tada
