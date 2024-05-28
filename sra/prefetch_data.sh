#!/bin/sh
BASE_DIR=$(pwd -P)
OUT_DIR="$BASE_DIR/cache"

echo "Prefetching..."

printf "\nE. Coli:\n"
prefetch SRR29080237 -O $OUT_DIR

printf "\nSmallpox:\n"
prefetch ERR4333272 -O $OUT_DIR

printf "\nPolio:\n"
prefetch SRR25182350 -O $OUT_DIR

printf "\nRubella:\n"
prefetch SRR26754123 -O $OUT_DIR
