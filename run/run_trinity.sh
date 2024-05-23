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
TRINITY_OUT_DIR="$OUT_DIR/trinity/trinity_$FASTQ_FILE_NAME"
TIMEOUT_SECONDS=10

mkdir -p $TRINITY_OUT_DIR

Trinity --seqType fq --single $FASTQ_PATH --max_memory 6G --output $TRINITY_OUT_DIR &

TRINITY_PID=$!

"$MONITOR_PATH" $TRINITY_PID $TRINITY_OUT_DIR $TIMEOUT_SECONDS

