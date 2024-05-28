set -e
true
true
/opt/miniconda/bin/spades-hammer /home/assembly/out/spades/spades_ERR4333272_1/corrected/configs/config.info
/opt/miniconda/bin/python /opt/miniconda/share/spades/spades_pipeline/scripts/compress_all.py --input_file /home/assembly/out/spades/spades_ERR4333272_1/corrected/corrected.yaml --ext_python_modules_home /opt/miniconda/share/spades --max_threads 16 --output_dir /home/assembly/out/spades/spades_ERR4333272_1/corrected --gzip_output
true
true
/opt/miniconda/bin/spades-core /home/assembly/out/spades/spades_ERR4333272_1/K21/configs/config.info
/opt/miniconda/bin/spades-core /home/assembly/out/spades/spades_ERR4333272_1/K33/configs/config.info
/opt/miniconda/bin/spades-core /home/assembly/out/spades/spades_ERR4333272_1/K55/configs/config.info
/opt/miniconda/bin/python /opt/miniconda/share/spades/spades_pipeline/scripts/copy_files.py /home/assembly/out/spades/spades_ERR4333272_1/K55/before_rr.fasta /home/assembly/out/spades/spades_ERR4333272_1/before_rr.fasta /home/assembly/out/spades/spades_ERR4333272_1/K55/assembly_graph_after_simplification.gfa /home/assembly/out/spades/spades_ERR4333272_1/assembly_graph_after_simplification.gfa /home/assembly/out/spades/spades_ERR4333272_1/K55/final_contigs.fasta /home/assembly/out/spades/spades_ERR4333272_1/contigs.fasta /home/assembly/out/spades/spades_ERR4333272_1/K55/first_pe_contigs.fasta /home/assembly/out/spades/spades_ERR4333272_1/first_pe_contigs.fasta /home/assembly/out/spades/spades_ERR4333272_1/K55/strain_graph.gfa /home/assembly/out/spades/spades_ERR4333272_1/strain_graph.gfa /home/assembly/out/spades/spades_ERR4333272_1/K55/scaffolds.fasta /home/assembly/out/spades/spades_ERR4333272_1/scaffolds.fasta /home/assembly/out/spades/spades_ERR4333272_1/K55/scaffolds.paths /home/assembly/out/spades/spades_ERR4333272_1/scaffolds.paths /home/assembly/out/spades/spades_ERR4333272_1/K55/assembly_graph_with_scaffolds.gfa /home/assembly/out/spades/spades_ERR4333272_1/assembly_graph_with_scaffolds.gfa /home/assembly/out/spades/spades_ERR4333272_1/K55/assembly_graph.fastg /home/assembly/out/spades/spades_ERR4333272_1/assembly_graph.fastg /home/assembly/out/spades/spades_ERR4333272_1/K55/final_contigs.paths /home/assembly/out/spades/spades_ERR4333272_1/contigs.paths
true
/opt/miniconda/bin/python /opt/miniconda/share/spades/spades_pipeline/scripts/breaking_scaffolds_script.py --result_scaffolds_filename /home/assembly/out/spades/spades_ERR4333272_1/scaffolds.fasta --misc_dir /home/assembly/out/spades/spades_ERR4333272_1/misc --threshold_for_breaking_scaffolds 3
true
