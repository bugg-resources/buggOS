#!/bin/bash

# Get the ID of the first running container
container_id=$(docker ps -q | head -n 1)

docker stop "$container_id"
docker rm "$container_id"
