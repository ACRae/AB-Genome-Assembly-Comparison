#!/bin/sh

OUTPUT_DIR="./fastq"

if [ ! -d $OUTPUT_DIR ]; then
    mkdir $OUTPUT_DIR
fi

echo "Dumping fastq..."

printf "\nE. Coli:\n"
fasterq-dump SRR29080237 -O $OUTPUT_DIR

printf "\nSmallpox:\n"
fasterq-dump ERR4333272 -O $OUTPUT_DIR

printf "\nPolio:\n"
fasterq-dump SRR25182350 -O $OUTPUT_DIR

printf "\nRubella:\n"
fasterq-dump SRR26754123 -O $OUTPUT_DIR

