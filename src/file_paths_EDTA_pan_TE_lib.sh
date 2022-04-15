# Makes a txt file with absolute file paths pointing to each genome's individual TE lib file
# *GENOME_NewNames.fasta.mod.EDTA.TElib.fa
# Where GENOME is the variable.

output_file=/mnt/research/edgerpat_lab/Scotty/Blueberry_Pangenome_TE_Analysis/results/Blueberry/file_paths_pan_TE_lib.txt
rm -f $output_file

for dir in $(find /mnt/research/edgerpat_lab/Scotty/Blueberry_Pangenome_TE_Analysis/results/Blueberry -maxdepth 2 -type d)
do
	if [ "${dir: -10}" == "Annotation" ]
	then	
		anno_dir=$dir
		for a_file in $(find -L $anno_dir -maxdepth 1 -type f)
			do
				if [ "${a_file: 13}" == "EDTA.TElib.fa" ]
				then
					TE_lib_file=$a_file
					echo "$TE_lib_file" >> $output_file
					[  -z "$TE_lib_file" ] && echo "FALURE" && exit 1
				fi
			done
	fi
done

sort $output_file -o $output_file
