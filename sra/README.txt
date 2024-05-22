Using Flye:
flye --nano-raw <file>.fastq --out-dir <path>

Using Abyss:
abyss-pe name=ecoli k=96 B=2G in='reads1.fa reads2.fa'

Using Trinity:
Trinity --seqType fq --left reads_1.fq --right reads_2.fq --CPU 6 --max_memory 20G

Using Plass:
plass assemble examples/reads_1.fastq.gz assembly.fas tmp


1. Setup the workspace:
* Run ./setup_workspace.sh

2. Save SRA files to local cache:
* Run ./prefetch_data.sh

3. Dump the fastq files:
* Run ./dump_fastq.sh
