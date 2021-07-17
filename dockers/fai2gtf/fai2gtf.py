#!/usr/bin/env python

import sys
import argparse

def add_line(feature, gene_name, seq_length, gene_id, transcript_id):

    if feature not in ["gene", "transcript", "exon"]:
        raise Exception("Invalid feature!")

    # Ensembl uses the attribute name `gene_biotype` whereas GENCODE uses `gene_type`.
    # here, we'll just use `gene_biotype`.

    # attributes:
    # construct a semicolon-separated list of tag-value pairs
    # providing additional information about each feature.
    # fixme: use gtf writer instead
    if feature == "gene":
        attributes = 'gene_id "{0}"; gene_name "{1}"; gene_biotype "transgene";'.format(
            gene_id, gene_name
        )
    else:
        attributes = 'gene_id "{0}"; transcript_id "{1}"; gene_name "{2}"; gene_biotype "transgene";'.format(
            gene_id, transcript_id, gene_name
        )

    out = [
        gene_name, "TRANSGENE", feature, 1, seq_length, ".", "+", ".", attributes
    ]

    return "\t".join(map(str, out))


def main(path_faidx, gene_id, transcript_id):

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
            # tdTomato  TRANSGENE  gene        1	1431	.	+	.	gene_id "ENSMUSG09000000002"; gene_name "tdTomato"; gene_biotype "transgene";
            # tdTomato  TRANSGENE  transcript  1	1431	.	+	.	gene_id "ENSMUSG09000000002"; transcript_id "ENSMUST09000000002"; gene_name "tdTomato"; gene_biotype "transgene";
            # tdTomato  TRANSGENE  exon        1	1431	.	+	.	gene_id "ENSMUSG09000000002"; transcript_id "ENSMUST09000000002"; gene_name "tdTomato"; gene_biotype "transgene";

            gene_line = add_line("gene", gene_name, seq_length, gene_id, None)
            transcript_line = add_line("transcript", gene_name, seq_length, gene_id, transcript_id)
            exon_line = add_line("exon", gene_name, seq_length, gene_id, transcript_id)

            print(gene_line)
            print(transcript_line)
            print(exon_line)


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
        "--gene-id",
        action="store",
        dest="gene_id",
        help="Ensenmbl Gene ID (e.g. ENSMUSG00000900001)",
        required=True
    )

    parser.add_argument(
        "--transcript-id",
        action="store",
        dest="transcript_id",
        help="Ensenmbl Transcript ID (e.g. ENSMUST00000900001)",
        required=True
    )

    # parse arguments
    params = parser.parse_args()

    return params


if __name__ == "__main__":

    params = parse_arguments()

    main(
        params.path_faidx,
        params.gene_id,
        params.transcript_id
    )
