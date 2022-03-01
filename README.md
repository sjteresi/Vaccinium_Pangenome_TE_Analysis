# Blueberry Pangenome TE Analysis
Collection of scipts and methods to create a pangenome transposable element (TE) library, as well as analyze the TE differences amongst core and dispensable genes.


# Contact Information:
| Role          | Name          | GitHub                                                  | Email              |
|---------------|---------------|---------------------------------------------------------|--------------------|
| Analyst: | Scott Teresi  | [Personal GitHub](https://github.com/sjteresi) | <teresisc@msu.edu> |
| Project Lead: | Alan Yocca  | [Personal GitHub](https://github.com/aeyocca) | <aeyap42@gmail.com> |
| PI: | Patrick Edger | [Lab GitHub](https://github.com/EdgerLab) | <edgerpat@msu.edu> |

# Requirements:
We used EDTA v2.0.0 to generate our TE datasets.
Python package requirements can be found at `requirements/python_requirements.txt`

# Create a Pangenome TE Library/Annotation (EDTA):
The goal is to create a pangenome TE annotation for each genome group, i.e. one for the blueberries, and one for the cranberries.
## Creating Individual Libraries:
First, individual repeat libaries must be made for each genome. To do this, we need to run EDTA for each genome, and in order to run EDTA we have to do some simple file editing of our input data (genome FASTA) in order to get it in a format that EDTA likes.

