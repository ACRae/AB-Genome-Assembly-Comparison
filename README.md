# Genome Assemblers Comparison
A repistory for comparison of several genome assemblers.

<br>

# Instructions 

## 1. Build image and run docker container
* Windows: Run the `./run_container.bat`
* Linux & MacOS: Run the `./run_container.sh`

This will build the docker image and automatically run the container in the terminal.

You can use this script to open the container again.


## 2. Get the SRA data
In the container terminal run:
1. `./prefetch_data.sh`
2. `./fasterq_dump.sh`

You will find the `cache` and `fastq` folders in your directory.

You will only need to do this once!

## 3. Run the assemblers
In order to run all the assemblers all you have to do is:

`run_all <path to the fastq folder> <RAM usage>`

Example: `run_all fastq 16G`

This will start the genome assembly for every data sample.

## 4. Evaluate the contigs
Keep in mind that some assemblies might fail without warning and so some evaluations are not present.

The evaluation is done using [quast]`https://quast.sourceforge.net/`.

To evaluate the model run `./quast_eval.sh`

## 5. Plot monitor graphs (experimental)
A monitor program was implemented to keep track of the RAM memory usage and the CPU usage. It is experimental and the results tend to vary.

This step attempts to plot the RAM and CPU usage over time for each assembly tool run.

Install python requirements:
* `pip install -r requirements.txt [--break-system-packages]`

Get the geckodriver and setup PATH:
* https://github.com/mozilla/geckodriver/releases

Plot graphs:
* Run: `python3 plot_monitor.py`
