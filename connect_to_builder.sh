#!/bin/bash

# Get the ID of the first running container
CONTAINER_ID=$(docker ps --format "{{.ID}}" | head -n 1)

# Check if the container ID is not empty
if [ -z "$CONTAINER_ID" ]
then
    echo "No running containers found."
    exit 1
fi

# Launch a bash shell in the container
docker exec -it $CONTAINER_ID /bin/bash

