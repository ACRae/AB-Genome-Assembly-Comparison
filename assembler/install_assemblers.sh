echo "Installing assemblers via conda..."

printf "\nAbyss:\n"
#install abyss
conda install -c bioconda -c conda-forge abyss -y

printf "\nSpades:\n"
#install abyss
conda install -c bioconda -c conda-forge spades -y

printf "\nTrinity:\n"
#install trinity
conda install -c bioconda -c conda-forge trinity -y
