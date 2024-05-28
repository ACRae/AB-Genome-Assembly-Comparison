#!/bin/bash

BASE_FOLDER=$(pwd -P)

FASTQ_PATH=$1
RAM_USAGE=${2:-"5G"}
TIMEOUT_SECONDS=${3:-10}
MONITOR_PATH=${4:-"monitor.sh"}

# Check if FASTQ_PATH is provided
if [ -z "$FASTQ_PATH" ]; then
    echo "Input file is not provided!"
    exit 1
fi



FASTQ_FILE_NAME="${FASTQ_PATH##*/}"
FASTQ_FILE_NAME="${FASTQ_FILE_NAME%.*}"

if [ ! -f $FASTQ_PATH ]; then
    echo $FASTQ_PATH
    echo "Input file not found!"
    exit 1
fi

OUT_DIR="$BASE_FOLDER/out"
TRINITY_OUT_DIR="$OUT_DIR/trinity/trinity_$FASTQ_FILE_NAME"
TIMEOUT_SECONDS=10

mkdir -p $TRINITY_OUT_DIR

Trinity --seqType fq --single $FASTQ_PATH --max_memory $RAM_USAGE --output $TRINITY_OUT_DIR --no_salmon &

TRINITY_PID=$!

"$MONITOR_PATH" $TRINITY_PID $TRINITY_OUT_DIR $TIMEOUT_SECONDS

