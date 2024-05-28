#!/bin/bash
BASE_FOLDER=$(pwd -P)

# abyss-pe name=ecoli k=96 B=2G in='reads1.fa reads2.fa' -C ...

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
ABYSS_OUT_DIR="$OUT_DIR/abyss/abyss_$FASTQ_FILE_NAME"

mkdir -p $ABYSS_OUT_DIR

abyss-pe name=$FASTQ_FILE_NAME k=96 B=$RAM_USAGE in="$ABYSS_PATH" -C $ABYSS_OUT_DIR &

ABYSS_PID=$!

"$MONITOR_PATH" $ABYSS_PID $ABYSS_OUT_DIR $TIMEOUT_SECONDS

