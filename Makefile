# Script to recreate analyses
#  __author__ Scott Teresi
#
# TODO fill in description
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
DEV_DATA := $(ROOT_DIR)/data
DEV_RESULTS := $(ROOT_DIR)/results
SHELL=/bin/bash

#.PHONY: fix_regular_fasta_names

# NOTE: Go through the directories of the blueberry genomes, 
# and create a new standard FASTA file with sequence IDs that
# conform to the sequence ID length requirements of EDTA. 
.ONESHELL:
.SILENT:
.SHELLFLAGS := -euo pipefail -c
fix_regular_fasta_names:
	for dir in $$(find /mnt/research/edgerpat_lab/Scotty/Blueberry_Pangenome_TE_Analysis/data/Blueberry -mindepth 1 -type d)
		do
			for a_file in $$(find -L $$dir -mindepth 1 -type f )
				do
				echo $$a_file
					if [ "$${a_file: -6}" == ".fasta" ]
					then
						fasta_file=$$a_file
					fi
				done
				# Define genome name from dir
				genome_name=$$(basename $$dir)
				# Define output dir from dir and path
				output_location=$$(realpath "$$dir/../../../results/Blueberry/$$genome_name")
		python $(ROOT_DIR)/src/fix_fasta_names.py $$fasta_file $$genome_name $$output_location
		done
		
# NOTE: Go through the directories of the blueberry genomes, 
# and create a CDS FASTA file with sequence IDs that
# conform to the sequence ID length requirements of EDTA. 
.ONESHELL:
.SILENT:
.SHELLFLAGS := -euo pipefail -c
generate_cds_and_fix_names:
	for dir in $$(find /mnt/research/edgerpat_lab/Scotty/Blueberry_Pangenome_TE_Analysis/data/Blueberry -mindepth 1 -type d)
	do
		for a_file in $$(find -L $$dir -mindepth 1 -type f)
			do
				if [ "$${a_file: -4}" == ".gff" ]
				then
					gff_file=$$a_file
				fi
				if [ "$${a_file: -6}" == ".fasta" ]
				then
					fasta_file=$$a_file
					#echo $$fasta_file
				fi
			done
			# Define genome name from dir
			genome_name=$$(basename $$dir)
			# Define output dir from dir and path
			output_location=$$(realpath "$$dir/../../../results/Blueberry/$$genome_name")
			# Define output (CDS fasta) filename from path
			output_filename="$$output_location/$${genome_name}_CDS.fasta"
			# Begin running GFFRead
			$$(/mnt/research/edgerpat_lab/Scotty/gffread/gffread -x $$output_filename -g $$fasta_file $$gff_file)
			# Fix gene names in that output. They are too long, and EDTA won't like it.
			python $(ROOT_DIR)/src/fix_cds_names.py $$output_filename $$genome_name $$output_location
			# Compress the CDS file with the original names, to consere space
			gzip $$output_filename
	done
