#!/bin/sh

V=3.1.1

# Update package index and install necessary packages
apt-get update && apt-get install -y --no-install-recommends \
    curl \
    perl \
    libxml-libxml-perl \
    && rm -rf /var/lib/apt/lists/*

# Set up SRA Toolkit
echo "installing SRA Toolkit $V to /usr/local/ncbi"
rm -rf /usr/local/ncbi /etc/ncbi /etc/profile.d/sra-tools* # remove old install if any

curl -SL "https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/$V/sratoolkit.$V-centos_linux64-cloud.tar.gz" | tar xz -C /

echo "Please 'source /etc/profile.d/sra-tools.sh' to setup your path"

