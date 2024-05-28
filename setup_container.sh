#!/bin/bash

LOCAL_PATH=$(pwd -P)
DATA_PATH="$LOCAL_PATH/sra/"
TARGET_PATH="/home/assembly"

# Get the current image ID (if it exists)
CURRENT_IMAGE_ID=$(docker images -q assemblers_image)

# Build the Docker image
docker build -t assemblers_image .

# Get the new image ID after build
NEW_IMAGE_ID=$(docker images -q assemblers_image)

clear
# Check if the container exists
if [ "$(docker ps -aq -f name=assemblers_cont)" ]; then
    if [ "$CURRENT_IMAGE_ID" != "$NEW_IMAGE_ID" ]; then
        echo "Image has changed. Removing existing container..."
        docker rm -f assemblers_cont
        echo "Creating a new container..."
        docker run -it --name assemblers_cont --mount type=bind,source=$DATA_PATH,target=$TARGET_PATH assemblers_image
    else
        echo "Image has not changed. Starting existing container..."
        docker start -ai assemblers_cont
    fi
else
    echo "Container does not exist. Creating a new container..."
    docker run -it --name assemblers_cont --mount type=bind,source=$DATA_PATH,target=$TARGET_PATH assemblers_image
fi
