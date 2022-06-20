# Blueberry Pangenome TE Analysis
Collection of scipts and methods to create a pangenome transposable element (TE) library, as well as analyze the TE differences amongst core and dispensable genes.
Three pan-genome repeat libraries were generated using the scripts in this repository, one for the northern blueberries, one for the southern blueberries, and one for the cranberries

# Contact Information:
| Role          | Name          | GitHub                                                  | Email              |
|---------------|---------------|---------------------------------------------------------|--------------------|
| Analyst: | Scott Teresi  | [Personal GitHub](https://github.com/sjteresi) | <teresisc@msu.edu> |
| Project Lead: | Alan Yocca  | [Personal GitHub](https://github.com/aeyocca) | <aeyap42@gmail.com> |
| PI: | Patrick Edger | [Lab GitHub](https://github.com/EdgerLab) | <edgerpat@msu.edu> |

# Requirements:
We used EDTA v2.0.0 to generate our TE datasets.
Python package requirements can be found at `requirements/python_requirements.txt`

# Short Summary for Manuscript:
EDTA v2.0.0 was used to generate a pan-genome TE annotation.
Default parameters were used in all cases except for the usage of the `--sensitive 1` parameter which employs RepeatModeler to identify remaining TEs.
First, individual repeat libraries were generated independently for each genome.
Then, these libraries were filtered and combined using EDTA's `make_panTElib.pl` script to generate a pan-genome repeat library for each genome group.
Finally, the pan-genome repeat library was used to re-annotate each source genome. 
Scripts and documentation for this analysis can be found at: [https://github.com/sjteresi/Vaccinium_Pangenome_TE_Analysis](https://github.com/sjteresi/Vaccinium_Pangenome_TE_Analysis). 

# More Detailed Guide:
The goal is to create a pangenome TE annotation for each genome group, i.e. one for the northern blueberries, the southern blueberries, and one for the cranberries.

## Creating the Individual Libraries:
First, individual repeat libaries must be made for each genome. To do this, we need to run EDTA for each genome, and in order to run EDTA we have to do some simple file editing of our input data (genome FASTA) in order to get it in a format that EDTA likes.

## Filtering/Merging the Libaries:
TODO fill in

## Using the Pan-Genome Libraries to Re-Annotate:
TODO fill in
