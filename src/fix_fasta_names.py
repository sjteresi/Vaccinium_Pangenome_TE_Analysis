#!/usr/bin/env python3

"""
Reformat Fasta files for EDTA usage
"""

__author__ = "Scott Teresi"

import argparse
import os
import logging
import coloredlogs
from Bio import SeqIO


def reformat_seq_iq(input_fasta, genome_name, output_dir, logger):
    """
    Reformat a regular FASTA file to have shorter sequence ID names for EDTA

    Args:
        input_fasta (str): String path to input fasta file

        genome_name (str): String for genome name

        output_dir (str): Path to output dir

        logger (logging.Logger): Object to log information to

    Returns:
        None, just saves the edited FASTA file to disk. Also writes a
        conversion table to disk for the old names and their new name
        counterparts
    """
    # MAGIC file suffixes
    new_fasta = os.path.join(output_dir, (genome_name + "_NewNames.fasta"))

    # NOTE we want all sequences used.
    # GENERAL RULES for renaming sequences:
    # Anything with the 'NODE' prefix will be kept up to the second underscore,
    # the first set of numbers that follows the NODE prefix seems to be
    # important.
    # Anything with 'VaccDscaff' needs to be trimmed because 4 digit scaffold
    # numbers exceed the character limit. Going to truncate 'Vacc'
    # Anything with 'tig' should be alright in terms of length

    with open(input_fasta, "r") as input_fasta:
        with open(new_fasta, "w") as new_fasta_output:
            for s_record in SeqIO.parse(input_fasta, "fasta"):

                # NB handle the VaccDscaff rules here.
                if s_record.id[:4] == "Vacc":
                    s_record.id = s_record.id[4:]
                    s_record.description = ""  # NB edit the description so that when
                    # we rewrite we don't have the extraneous info

                # NB handle the NODE rules here.
                if s_record.id[:4] == "NODE":
                    split_list = s_record.id.split("_")[:2]
                    s_record.id = "_".join(split_list)
                    s_record.description = ""  # NB edit the description so that when
                    # we rewrite we don't have the extraneous info

                if len(s_record.id) > 13:  # NB sanity check for EDTA
                    # compliance
                    print(s_record.id)
                    raise ValueError(
                        """Sequence ID greater than 13, EDTA will
                                     not like this."""
                    )

                SeqIO.write(s_record, new_fasta_output, "fasta")

    logger.info("Finished writing new fasta to: %s" % new_fasta)


if __name__ == "__main__":

    path_main = os.path.abspath(__file__)
    dir_main = os.path.dirname(path_main)
    parser = argparse.ArgumentParser(description="Reformat FASTA for EDTA")

    parser.add_argument("fasta_input_file", type=str, help="parent path of fasta file")
    parser.add_argument("genome_id", type=str, help="name of genome")

    parser.add_argument(
        "output_dir",
        type=str,
        help="Parent directory to output results",
    )
    parser.add_argument(
        "-v", "--verbose", action="store_true", help="set debugging level to DEBUG"
    )
    args = parser.parse_args()
    args.fasta_input_file = os.path.abspath(args.fasta_input_file)
    args.output_dir = os.path.abspath(args.output_dir)
    log_level = logging.DEBUG if args.verbose else logging.INFO
    logger = logging.getLogger(__name__)
    coloredlogs.install(level=log_level)

    reformat_seq_iq(args.fasta_input_file, args.genome_id, args.output_dir, logger)
