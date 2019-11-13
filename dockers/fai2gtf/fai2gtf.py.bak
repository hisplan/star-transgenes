#!/usr/bin/env python

import sys

for line in sys.stdin:
    F = line.strip().split("\t")
    F0 = F[0].split(';')

    comment = 'gene_id "%s"; transcript_id "%s"; gene_name "%s";' % (
        F0[1], F0[1], F0[0])
    out = [F0[0] + "_01", "TRANSGENE", "gene", 1, F[1], ".", "+", ".", comment]

    print("\t".join(map(str, out)))
    out[2] = "transcript"
    print("\t".join(map(str, out)))
    out[2] = "exon"
    print("\t".join(map(str, out)))
