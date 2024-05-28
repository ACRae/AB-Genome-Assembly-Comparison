#!/bin/sh
BASE_DIR=$(pwd -P)
OUT_DIR="$BASE_DIR/cache"

echo "Prefetching..."

printf "\nE. Coli:\n"
prefetch SRR29080237 -O $OUT_DIR

printf "\nEnterovirus:\n"
prefetch SRR28708090 -O $OUT_DIR

printf "\nInfluenza A:\n"
prefetch SRR29182424 -O $OUT_DIR

printf "\nRubella:\n"
prefetch SRR26754123 -O $OUT_DIR
