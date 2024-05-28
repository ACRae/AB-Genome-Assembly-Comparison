#!/bin/bash

# Get the current directory
BASE_FOLDER=$(pwd -P)

# Get the FASTQ_PATH from the first argument
FASTQ_PATH=$1

# Split the input string into two variables
set -- $FASTQ_PATH

# Assign the split values to individual variables
FASTQ_LEFT=$1
FASTQ_RIGHT=$2

# Handle optional parameters with default values
RAM_USAGE=${3:-"5G"}
TIMEOUT_SECONDS=${4:-10}
MONITOR_PATH=${5:-"monitor.sh"}


# Check if FASTQ_PATH is provided
if [ -z "$FASTQ_PATH" ]; then
    echo "Input file is not provided!"
    exit 1
fi

# Extract and modify the FASTQ file name from FASTQ_LEFT
FASTQ_FILE_NAME="${FASTQ_LEFT##*/}"   # Get the file name
FASTQ_FILE_NAME="${FASTQ_FILE_NAME%.*}"  # Remove the extension
FASTQ_FILE_NAME="${FASTQ_FILE_NAME//_/}" # Remove underscores


# Check if both files exist
if [ ! -f "$FASTQ_RIGHT" ]; then
    echo "$FASTQ_RIGHT"
    echo "Input file not found!"
    exit 1
fi

if [ ! -f "$FASTQ_LEFT" ]; then
    echo "$FASTQ_LEFT"
    echo "Input file not found!"
    exit 1
fi


OUT_DIR="$BASE_FOLDER/out"
ABYSS_OUT_DIR="$OUT_DIR/abyss/abyss_$FASTQ_FILE_NAME"

mkdir -p $ABYSS_OUT_DIR

abyss-pe name="$ABYSS_OUT_DIR/$FASTQ_FILE_NAME" k=96 B=$RAM_USAGE in="$FASTQ_PATH" &

ABYSS_PID=$!

"$MONITOR_PATH" $ABYSS_PID $ABYSS_OUT_DIR $TIMEOUT_SECONDS

