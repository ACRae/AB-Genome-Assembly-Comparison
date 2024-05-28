# Genome Assemblers Comparison
A repistory for comparison of several genome assemblers.

<br>

# Instructions 

## Build image and run docker container 
* Windows: Run the `./run_container.bat`
* Linux & MacOS: Run the `./run_container.sh`

This will build the docker image and automatically run the container in the terminal. You can use this script to open the container again.


## Get the SRA data 
In the container terminal run:
1. `./prefetch_data.sh`
2. `./fasterq_dump.sh`

You will find the `cache` and `fastq` folders in your directory.

## Run the assemblers
In order to run all the assemblers all you have to do is:

`run_all <path to the fastq file>`