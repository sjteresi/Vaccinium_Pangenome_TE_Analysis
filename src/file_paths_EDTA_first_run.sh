# Creates a txt file with a CDS FASTA and a regular FASTA every 2 lines. Used for EDTA array job.
output_file=/mnt/research/edgerpat_lab/Scotty/Blueberry_Pangenome_TE_Analysis/results/Blueberry/file_paths.txt
rm -f $output_file

for dir in $(find /mnt/research/edgerpat_lab/Scotty/Blueberry_Pangenome_TE_Analysis/results/Blueberry -mindepth 1 -type d)
do
	# Define genome name from dir
	genome_name=$(basename $dir)
	for a_file in $(find -L $dir -mindepth 1 -type f)
		do
			if [ "${a_file: -19}" == "_CDS_NewNames.fasta" ]
			then
				echo "$genome_name" >> $output_file
				processed_CDS_FASTA=$a_file
				echo "$processed_CDS_FASTA" >> $output_file
				[  -z "$processed_CDS_FASTA" ] && echo "FALURE" && exit 1
			fi

			
			if [ "$a_file" == "$dir/${genome_name}_NewNames.fasta" ]
			then
				processed_FASTA=$a_file
				echo "$processed_FASTA" >> $output_file
				[  -z "$processed_FASTA" ] && echo "FALURE" && exit 1
			fi

		done

	sort $output_file -o $output_file
done
