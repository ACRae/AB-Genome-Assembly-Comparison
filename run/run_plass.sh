#!/bin/bash

BASE_FOLDER=$(pwd -P)

# plass assemble examples/reads_1.fastq.gz assembly.fas tmp

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
PLASS_OUT_DIR="$OUT_DIR/plass/plass_$FASTQ_FILE_NAME"
TIMEOUT_SECONDS=10

mkdir -p $PLASS_OUT_DIR

plass assemble $FASTQ_PATH "$PLASS_OUT_DIR/assembly.fastq" /tmp &

PLASS_PID=$!

"$MONITOR_PATH" $PLASS_PID $PLASS_OUT_DIR $TIMEOUT_SECONDS
