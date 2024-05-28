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
TRINITY_OUT_DIR="$OUT_DIR/trinity/trinity_$FASTQ_FILE_NAME"
TIMEOUT_SECONDS=10

mkdir -p $TRINITY_OUT_DIR

Trinity --seqType fq --left $FASTQ_RIGHT --right $FASTQ_LEFT --max_memory $RAM_USAGE --output $TRINITY_OUT_DIR --no_salmon &

TRINITY_PID=$!

"$MONITOR_PATH" $TRINITY_PID $TRINITY_OUT_DIR $TIMEOUT_SECONDS

