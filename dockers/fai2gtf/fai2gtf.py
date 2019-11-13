#!/usr/bin/env python

import sys
import argparse


def main(path_faidx, ensembl_id):

    with open(path_faidx, "rt") as fo:

        lines = fo.readlines()

        for line in lines:

            line = line.strip()

            # http://www.htslib.org/doc/faidx.html
            # NAME      LENGTH   OFFSET    LINEBASES   LINEWIDTH
            # tdTomato  1431     29        1431        1432
            columns = line.strip().split("\t")

            gene_name = columns[0]
            seq_length = columns[1]

            # https://useast.ensembl.org/info/website/upload/gff.html
            # tdTomato  TRANSGENE  gene        1	1431	.	+	.	gene_id "ENSMUSG09000000002"; transcript_id "ENSMUSG09000000002"; gene_name "tdTomato";
            # tdTomato  TRANSGENE  transcript  1	1431	.	+	.	gene_id "ENSMUSG09000000002"; transcript_id "ENSMUSG09000000002"; gene_name "tdTomato";
            # tdTomato  TRANSGENE  exon        1	1431	.	+	.	gene_id "ENSMUSG09000000002"; transcript_id "ENSMUSG09000000002"; gene_name "tdTomato";

            # fixme: use gtf writer instead
            comment = 'gene_id "{0}"; transcript_id "{0}"; gene_name "{1}";'.format(
                ensembl_id, gene_name
            )

            out = [
                gene_name, "TRANSGENE", "gene", 1, seq_length, ".", "+", ".", comment
            ]

            print("\t".join(map(str, out)))
            out[2] = "transcript"
            print("\t".join(map(str, out)))
            out[2] = "exon"
            print("\t".join(map(str, out)))


def parse_arguments():

    parser = argparse.ArgumentParser()

    parser.add_argument(
        "--faidx",
        action="store",
        dest="path_faidx",
        help="path to fasta index file (*.fai)",
        required=True
    )

    # https://useast.ensembl.org/info/genome/stable_ids/index.html
    parser.add_argument(
        "--ensembl-id",
        action="store",
        dest="ensembl_id",
        help="Ensenmbl ID",
        required=True
    )

    # parse arguments
    params = parser.parse_args()

    return params


if __name__ == "__main__":

    params = parse_arguments()

    main(
        params.path_faidx,
        params.ensembl_id
    )
