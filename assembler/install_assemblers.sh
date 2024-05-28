echo "Installing assemblers via conda..."

printf "\nAbyss:\n"
#install abyss
conda install -c bioconda -c conda-forge abyss -y

printf "\nSpades:\n"
#install abyss
conda install -c bioconda -c conda-forge spades -y

printf "\nFlye:\n"
#install flye
conda install flye -y

printf "\nTrinity:\n"
#install trinity
conda install -c bioconda -c conda-forge trinity -y

printf "\nPlass:\n"
#install plass
conda install -c conda-forge -c bioconda plass -y
