Using Flye:
flye --nano-raw <file>.fastq --out-dir <path>

Using Abyss:
abyss-pe name=ecoli k=96 B=2G in='reads1.fa reads2.fa'

Using Trinity:
Trinity --seqType fq [--left reads_1.fq --right reads_2.fq  | --single read.fq] --CPU 6 --max_memory 20G --output <path>

Using Plass:
plass assemble examples/reads_1.fastq.gz assembly.fas tmp
