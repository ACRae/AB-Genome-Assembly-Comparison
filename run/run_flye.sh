#!/bin/bash

BASE_FOLDER=$(pwd -P)

FASTQ_PATH=$1

FASTQ_FILE_NAME="${FASTQ_PATH##*/}"
FASTQ_FILE_NAME="${FASTQ_FILE_NAME%.*}"

if [ ! -f $FASTQ_PATH ]; then
    echo $FASTQ_PATH
    echo "Input file not found!"
    exit 1
fi

MONITOR_PATH="../monitor/monitor.sh"
OUT_DIR="$BASE_FOLDER/out"
FLYE_OUT_DIR="$OUT_DIR/flye/$FASTQ_FILE_NAME"
TIMEOUT_SECONDS=10

mkdir -p $FLYE_OUT_DIR

flye --nano-raw $FASTQ_PATH --out-dir $FLYE_OUT_DIR &

FLYE_PID=$!

"$MONITOR_PATH" $FLYE_PID $FLYE_OUT_DIR $TIMEOUT_SECONDS
