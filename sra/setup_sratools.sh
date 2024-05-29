#!/bin/sh

V=3.1.1

# Set up SRA Toolkit
echo "installing SRA Toolkit 3.1.1 to /usr/local/ncbi"
rm -rf /usr/local/ncbi /etc/ncbi /etc/profile.d/sra-tools* # remove old install if any

curl -SL "https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/3.1.1/sratoolkit.3.1.1-centos_linux64-cloud.tar.gz" | tar xz -C /

echo "Please 'source /etc/profile.d/sra-tools.sh' to setup your path"

