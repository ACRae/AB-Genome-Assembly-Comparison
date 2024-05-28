#!/bin/sh
BASE_DIR=$(pwd -P)
SRA_CACHE_DIR=${1:-"$BASE_DIR/cache"}
OUTPUT_DIR="./fastq"

if [ ! -d $OUTPUT_DIR ]; then
    mkdir $OUTPUT_DIR
fi

echo "Dumping fastq..."

printf "\nE. Coli:\n"
fasterq-dump "$SRA_CACHE_DIR/SRR29080237" -O $OUTPUT_DIR

printf "\nSmallpox:\n"
fasterq-dump "$SRA_CACHE_DIR/ERR4333272" -O $OUTPUT_DIR

printf "\nPolio:\n"
fasterq-dump "$SRA_CACHE_DIR/SRR25182350" -O $OUTPUT_DIR

printf "\nRubella:\n"
fasterq-dump "$SRA_CACHE_DIR/SRR26754123" -O $OUTPUT_DIR

