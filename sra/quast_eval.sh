#!/bin/bash

# Base directory where the 'out' folder is located
BASE_DIR=$(pwd)
EVAL_DIR="${BASE_DIR}/eval"

# Create the eval directory if it does not exist
mkdir -p "$EVAL_DIR"


# Evaluate Spades
# Traverse through the directory structure
for contigs_file in $(find out/spades -type f -name "contigs.fasta"); do
    # Extract the spades_xxxx folder name
    spades_folder=$(basename $(dirname "$contigs_file"))

    # Define the output directory for QUAST results
    output_dir="${EVAL_DIR}/${spades_folder}"

    # Create the output directory if it does not exist
    mkdir -p "$output_dir"

    # Call quast.py with the contigs.fasta file
    quast.py "$contigs_file" -o "$output_dir"
done



# Evaluate abyss
# Traverse through the directory structure
for contigs_file in $(find out/abyss -type f -name "SRR*-6.fa"); do

     # Extract the spades_xxxx folder name
    folder=$(basename $(dirname "$contigs_file"))

    # Define the output directory for QUAST results
    output_dir="${EVAL_DIR}/${folder}"

    # Create the output directory if it does not exist
    mkdir -p "$output_dir"

    # Call quast.py with the contigs file
    quast.py "$contigs_file" -o "$output_dir"
done



# Evaluate Trinity
# Traverse through the directory structure
for contigs_file in $(find out/trinity -type f -name "trinity_SRR*.Trinity.fasta"); do
    # Extract the SRRXXXXXX identifier
    file_name=$(basename "$contigs_file")
    identifier=$(echo "$file_name" | sed -E 's/^trinity_(SRR[0-9]+)\.Trinity\.fasta$/\1/')

    # Define the output directory for QUAST results
    output_dir="${EVAL_DIR}/trinity_${identifier}"

    # Create the output directory if it does not exist
    mkdir -p "$output_dir"

    # Call quast.py with the contigs file
    quast.py "$contigs_file" -o "$output_dir"
done
