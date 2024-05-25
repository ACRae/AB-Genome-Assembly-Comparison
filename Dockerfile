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

# Run the install_assemblers.sh script directly from the host machine
COPY ./assembler/install_assemblers.sh /tmp/install_assemblers.sh
RUN chmod +x /tmp/install_assemblers.sh && \
    /bin/bash /tmp/install_assemblers.sh && \
    rm /tmp/install_assemblers.sh


# Copy the scripts into the container
COPY ./monitor/monitor.sh /usr/local/bin/monitor.sh
# Copy the contents of the run folder into a directory included in the PATH
COPY ./run/* /usr/local/bin/

# Make all scripts in the run folder executable
RUN chmod +x /usr/local/bin/*

# Set the entry point to bash
ENTRYPOINT ["/bin/bash"]
