# NOTE perhaps make input arg so I can do blueberry and cranberry separate? How can I grab the blueberyr or granberry dir

# Objective:
# Need to ITERATE through each directory,
# grab each DIRECTORY NAME and grab TWO FILES
# grab files by EXTENSION, e.g .gff and .fasta
# EXECUTE gffread with the APPROPRIATE OUTPUT FILENAME
# THEN run a SEPARATE COMMAND to FIX the GENE NAME.

for dir in $(find /home/scott/Documents/Uni/Research/Projects/Blueberry_Pangenome_TE_Analysis/data/Blueberry -mindepth 1 -type d)
	do
		for a_file in $(find $dir -mindepth 1 -type f)
			do
				if [ "${a_file: -4}" == ".gff" ]
				then
					gff_file=$a_file
					#echo "$gff_file"
				fi

				if [ "${a_file: -6}" == ".fasta" ]
				then
					fasta_file=$a_file
					#echo "$fasta_file"
				fi

			done

			# Define genome name from dir
			genome_name=$(basename $dir)

			# Define output dir from dir and path
			output_location=$(realpath "$dir/../../../results/Blueberry/$genome_name")
			# Define output (CDS fasta) filename from path
			output_filename="$output_location/${genome_name}_CDS.fasta"

			# TODO remove
			#echo
			#echo $fasta_file
			#echo $gff_file
			#echo

			# Begin running GFFRead
			$(/home/scott/Documents/Uni/Research/gffread/gffread -x $output_filename -g $fasta_file $gff_file)

	done
# TODO fix gene names in that output. They are too long, and EDTA won't like it.
