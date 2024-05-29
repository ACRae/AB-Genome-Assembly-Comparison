# Use the official Ubuntu image as a base
FROM ubuntu:20.04

# Set environment variables to non-interactive for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    sysstat \
    curl \
    perl \
    libxml-libxml-perl \
    pkg-config \
    libfreetype6-dev \
    libpng-dev \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean 

# Download and install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -b -p /opt/miniconda \
    && rm /tmp/miniconda.sh

# Update PATH environment variable
ENV PATH=/opt/miniconda/bin:$PATH

# Initialize conda
RUN conda init bash
RUN conda install -c bioconda abyss -y
RUN conda install -c bioconda spades -y
RUN conda install -c bioconda trinity -y

RUN pip install matplotlib --break-system-packages

# Install contigs quality assessment tool
RUN wget https://github.com/ablab/quast/releases/download/quast_5.2.0/quast-5.2.0.tar.gz -O /tmp/quast-5.2.0.tar.gz \
    && tar -xvf /tmp/quast-5.2.0.tar.gz -C /opt \
    && rm /tmp/quast-5.2.0.tar.gz

RUN /opt/quast-5.2.0/setup.py install

ENV PATH=/opt/quast-5.2.0:$PATH

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
