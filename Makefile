# Script to recreate analyses
#  __author__ Scott Teresi
#
# TODO fill in description
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
DEV_DATA := $(ROOT_DIR)/data
DEV_SCRIPTS := $(ROOT_DIR)/src
DEV_RESULTS := $(ROOT_DIR)/results
SHELL=/bin/bash

#.PHONY: fix_regular_fasta_names

# NOTE: Go through the directories of the blueberry genomes, 
# and create a new standard FASTA file with sequence IDs that
# conform to the sequence ID length requirements of EDTA. 
.ONESHELL:
.SILENT:
.SHELLFLAGS := -euo pipefail -c
fix_regular_fasta_names_blueberry:
	for dir in $$(find $(DEV_DATA)/Blueberry -mindepth 1 -type d)
	do
		gff_file=
		fasta_file=
		echo
		for a_file in $$(find -L $$dir -mindepth 1 -type f )
		do
			if [ "$${a_file: -6}" == ".fasta" ]
			then
				fasta_file=$$a_file
			fi
		done
		genome_name=$$(basename $$dir)
		echo "Genome Name: $$genome_name"
		output_location=$$(realpath "$$dir/../../../results/Blueberry/$$genome_name")
		mkdir -p $$output_location
		echo "Output Location: $$output_location"
		python $(ROOT_DIR)/src/fix_fasta_names.py $$fasta_file $$genome_name $$output_location
	done
		
# NOTE: Go through the directories of the blueberry genomes, 
# and create a CDS FASTA file with sequence IDs that
# conform to the sequence ID length requirements of EDTA. 
.ONESHELL:
.SILENT:
.SHELLFLAGS := -euo pipefail -c
generate_cds_and_fix_names_blueberry:
	for dir in $$(find $(DEV_DATA)/Blueberry -mindepth 1 -type d)
	do
		gff_file=
		fasta_file=
		echo 
		for a_file in $$(find -L $$dir -mindepth 1 -type f)
		do
			if [ "$${a_file: -4}" == ".gff" ]
			then
				gff_file=$$a_file
			fi
			if [ "$${a_file: -6}" == ".fasta" ]
			then
				fasta_file=$$a_file
			fi
		done
		if [ -z $${gff_file} ]  && [ -z $${fasta_file} ]
		then
			echo "FAILURE"
		else
			genome_name=$$(basename $$dir)
			echo "Genome Name: $$genome_name"
			output_location=$$(realpath "$$dir/../../../results/Blueberry/$$genome_name")
			mkdir -p $$output_location
			echo "Output Location: $$output_location"
			output_filename="$$output_location/$${genome_name}_CDS.fasta"
			echo "Output CDS Filename: $$output_filename"
			/mnt/research/edgerpat_lab/Scotty/gffread/gffread -x $$output_filename -g $$fasta_file $$gff_file
			python $(ROOT_DIR)/src/fix_cds_names.py $$output_filename $$genome_name $$output_location
			echo "Gzipping"
			gzip -f $$output_filename
		fi
	done

generate_file_paths_EDTA_first_run_blueberry:
	bash src/file_paths_EDTA_first_run_blueberry.sh
#-------------------------------------------------------------------------------------
.ONESHELL:
.SILENT:
.SHELLFLAGS := -euo pipefail -c
fix_regular_fasta_names_cranberry:
	for dir in $$(find $(DEV_DATA)/Cranberry -mindepth 1 -type d)
	do
		gff_file=
		fasta_file=
		echo
		for a_file in $$(find -L $$dir -mindepth 1 -type f )
		do
			if [ "$${a_file: -6}" == ".fasta" ]
			then
				fasta_file=$$a_file
			fi
		done
		genome_name=$$(basename $$dir)
		echo "Genome Name: $$genome_name"
		output_location=$$(realpath "$$dir/../../../results/Cranberry/$$genome_name")
		mkdir -p $$output_location
		echo "Output Location: $$output_location"
		python $(ROOT_DIR)/src/fix_fasta_names.py $$fasta_file $$genome_name $$output_location
	done

.ONESHELL:
.SILENT:
.SHELLFLAGS := -euo pipefail -c
generate_cds_and_fix_names_cranberry:
	for dir in $$(find $(DEV_DATA)/Cranberry -mindepth 1 -type d)
	do
		gff_file=
		fasta_file=
		echo 
		for a_file in $$(find -L $$dir -mindepth 1 -type f)
		do
			if [ "$${a_file: -4}" == ".gff" ]
			then
				gff_file=$$a_file
			fi
			if [ "$${a_file: -6}" == ".fasta" ]
			then
				fasta_file=$$a_file
			fi
		done
		if [ -z $${gff_file} ]  && [ -z $${fasta_file} ]
		then
			echo "FAILURE"
		else
			genome_name=$$(basename $$dir)
			echo "Genome Name: $$genome_name"
			output_location=$$(realpath "$$dir/../../../results/Cranberry/$$genome_name")
			mkdir -p $$output_location
			echo "Output Location: $$output_location"
			output_filename="$$output_location/$${genome_name}_CDS.fasta"
			echo "Output CDS Filename: $$output_filename"
			/mnt/research/edgerpat_lab/Scotty/gffread/gffread -x $$output_filename -g $$fasta_file $$gff_file
			python $(ROOT_DIR)/src/fix_cds_names.py $$output_filename $$genome_name $$output_location
			echo "Gzipping"
			gzip -f $$output_filename
		fi
	done

generate_file_paths_EDTA_first_run_cranberry:
	bash src/file_paths_EDTA_first_run_cranberry.sh
