#!/bin/bash

# Function to remove all stopped containers
cleanup_stopped_containers() {
    echo "Removing all stopped containers..."
    docker container prune -f
}

# Function to remove all unused images
cleanup_unused_images() {
    echo "Removing all unused images..."
    docker image prune -a -f
}

# Function to remove all unused volumes
cleanup_unused_volumes() {
    echo "Removing all unused volumes..."
    docker volume prune -f
}

# Function to remove all unused networks
cleanup_unused_networks() {
    echo "Removing all unused networks..."
    docker network prune -f
}

# Function to clear build cache
cleanup_build_cache() {
    echo "Removing build cache..."
    docker builder prune -a -f
}

# Main function
main() {
    echo "Starting Docker cleanup process..."

    cleanup_stopped_containers
    cleanup_unused_images
    cleanup_unused_volumes
    cleanup_unused_networks
    cleanup_build_cache

    echo "Docker cleanup process completed."
}

# Execute the main function
main
