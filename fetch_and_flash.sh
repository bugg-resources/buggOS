#!/bin/bash
url=$1

if [ -z "$url" ]; then
  echo "Usage: $0 <url>"
  exit 1
fi

KEY_FILE="/home/jeff/tools/soft/amazon-aws/aws-keys.pem"
BUGG="/dev/sda"

if [ ! -e "$BUGG" ]; then
  echo "CM4 device not found - make sure rpiboot is running"
  exit 1
fi 

if [[ $url != http* ]]; then
  if [ -f "$KEY_FILE" ]; then
      KEY="--key $KEY_FILE"
  else
    echo "Not an HTTP URL and no key found at ${KEY_FILE}. Exiting."  
    exit 1
  fi
fi

TADA="fish -c tada"
set -o pipefail # fail on any error in a pipeline
time curl \
  $KEY \
  $url \
  | gunzip \
  | sudo dd bs=10M of=BUGG \
  && tada