#!/bin/bash

# Get the ID of the first running container
container_id=$(docker ps -q | head -n 1)

# Check if a container ID was found
if [ -z "$container_id" ]; then
  echo "No running containers found."
  exit 1
fi

# Source path inside the container
file_pattern="/home/ubuntu/buggOS/pi-gen/deploy/*.gz"
matching_file=$(docker exec "$container_id" sh -c "ls $file_pattern")
source_path=$matching_file

# Destination path on the host
destination_path="/home/ubuntu/buggOS/deploy"
mkdir -p "$destination_path"

# Copy the file from the container to the host
docker cp "$container_id:$source_path" "$destination_path"

# Check if the copy was successful
if [ $? -eq 0 ]; then
  echo "File copied successfully from container to host."
else
  echo "Failed to copy file from container to host."
fi


