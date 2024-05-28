# Use the official Ubuntu image as a base
FROM ubuntu:20.04

# Set environment variables to non-interactive for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    sysstat \
    && apt-get clean

# Download and install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -b -p /opt/miniconda \
    && rm /tmp/miniconda.sh

# Update PATH environment variable
ENV PATH=/opt/miniconda/bin:$PATH

# Initialize conda
RUN conda init bash

RUN conda install -c bioconda -c conda-forge abyss -y
RUN conda install -c bioconda -c conda-forge spades -y
RUN conda install flye python=3.10 -y
RUN conda install -c bioconda -c conda-forge trinity -y
RUN conda install -c conda-forge -c bioconda plass -y


# Copy the setup-apt.sh script into the container
COPY ./sra/setup_sratools.sh /tmp/setup_sratools.sh

# Run the setup-apt.sh script
RUN chmod +x /tmp/setup_sratools.sh && \
    /tmp/setup_sratools.sh && \
    rm /tmp/setup_sratools.sh

# Update PATH environment variable
ENV PATH=/usr/local/ncbi/sra-tools/bin:$PATH

# Copy the scripts into the container
COPY ./monitor/* /usr/local/bin/
# Copy the contents of the run folder into a directory included in the PATH
COPY ./run/* /usr/local/bin/

# Make all scripts in the run folder executable
RUN chmod +x /usr/local/bin/*

# Create necessary directory
RUN mkdir -p /home/assembly

WORKDIR /home/assembly

# Set the entry point to bash
ENTRYPOINT ["/bin/bash"]
