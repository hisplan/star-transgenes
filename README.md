# SEQC Custom Genes

## Ensembl 85ish

### Human

```json
"SeqcCustomGenes.genomeReferenceFasta": "s3://dp-lab-home/chunj/seqc-custom-genes/Ensembl-85ish/hg38.fa",
"SeqcCustomGenes.annotationGtf": "s3://seqc-public/genomes/hg38_long_polya/annotations.gtf",
```

### Mouse

```json
"SeqcCustomGenes.genomeReferenceFasta": "s3://dp-lab-home/chunj/seqc-custom-genes/Ensembl-85ish/mm38.fa",
"SeqcCustomGenes.annotationGtf": "s3://seqc-public/genomes/mm38_long_polya/annotations.gtf",
```

## Ensembl 100

### Human

```json
"SeqcCustomGenes.genomeReferenceFasta": "s3://dp-lab-home/chunj/seqc-custom-genes/Ensembl-100/homo_sapiens.fa",
"SeqcCustomGenes.annotationGtf": "s3://dp-lab-home/chunj/seqc-custom-genes/Ensembl-100/homo_sapiens.gtf",
```

### Mouse

```json
"SeqcCustomGenes.genomeReferenceFasta": "s3://dp-lab-home/chunj/seqc-custom-genes/Ensembl-100/mus_musculus.fa",
"SeqcCustomGenes.annotationGtf": "s3://dp-lab-home/chunj/seqc-custom-genes/Ensembl-100/mus_musculus.gtf",
```

## Input FASTA File Requirements

1. Each FASTA file must conform to the standard FASTA file format specification.
1. The entire sequence must be in one line.
1. The last line of the FASTA file must end with a newline character (i.e. `\n`)
1. The FASTA filename must have a extension `.fa` (not `.fasta`)

*Bad Example 1*

```bash
$ cat egfp.fa
>EGFP
AGCAAGGGCGAGGAGCTGTTCACCGGGGTG
GTGCCCATCCTGGTCGAGCTGGACGGCGAC
GTAAACGGCCACAAGTTCAGCGTGTCCGGC
GAGGGCGAGGGCGATGCCACCTACGGCAAG
CTGACCCTGAAGTTCATCTGCACCACCGGC
AAGCTGCCCGTGCCCTGGCCCACCCTCGTG
ACCACCCTGACCTACGGCGTGCAGTGCTTC
AGCCGCTACCCCGACCACATGAAGCAGCAC
GACTTCTTCAAGTCCGCCATGCCCGAAGGC
TACGTCCAGGAGCGCACCATCTTCTTCAAG
GACGACGGCAACTACAAGACCCGCGCCGAG
GTGAAGTTCGAGGGCGACACCCTGGTGAAC
CGCATCGAGCTGAAGGGCATCGACTTCAAG
GAGGACGGCAACATCCTGGGGCACAAGCTG
GAGTACAACTACAACAGCCACAACGTCTAT
ATCATGGCCGACAAGCAGAAGAACGGCATC
AAGGTGAACTTCAAGATCCGCCACAACATC
GAGGACGGCAGCGTGCAGCTCGCCGACCAC
TACCAGCAGAACACCCCCATCGGCGACGGC
CCCGTGCTGCTGCCCGACAACCACTACCTG
AGCACCCAGTCCGCCCTGAGCAAAGACCCC
AACGAGAAGCGCGATCACATGGTCCTGCTG
GAGTTCGTGACCGCCGCCGGGATCACTCTC
GGCATGGACGAGCTGTACAAG
```

- Why: The whole sequence must not be splitted into multiple lines.
- How to correct: The entire sequence must be in one line as shown below:

```bash
>EGFP
AGCAAGGGCGAGGAGCTGTTCACCGGGGTGGTGCCCATCCTGGTCGAGCTGGACGGCGACGTAAACGGCCACAAGTTCAGCGTGTCCGGCGAGGGCGAGGGCGATGCCACCTACGGCAAGCTGACCCTGAAGTTCATCTGCACCACCGGCAAGCTGCCCGTGCCCTGGCCCACCCTCGTGACCACCCTGACCTACGGCGTGCAGTGCTTCAGCCGCTACCCCGACCACATGAAGCAGCACGACTTCTTCAAGTCCGCCATGCCCGAAGGCTACGTCCAGGAGCGCACCATCTTCTTCAAGGACGACGGCAACTACAAGACCCGCGCCGAGGTGAAGTTCGAGGGCGACACCCTGGTGAACCGCATCGAGCTGAAGGGCATCGACTTCAAGGAGGACGGCAACATCCTGGGGCACAAGCTGGAGTACAACTACAACAGCCACAACGTCTATATCATGGCCGACAAGCAGAAGAACGGCATCAAGGTGAACTTCAAGATCCGCCACAACATCGAGGACGGCAGCGTGCAGCTCGCCGACCACTACCAGCAGAACACCCCCATCGGCGACGGCCCCGTGCTGCTGCCCGACAACCACTACCTGAGCACCCAGTCCGCCCTGAGCAAAGACCCCAACGAGAAGCGCGATCACATGGTCCTGCTGGAGTTCGTGACCGCCGCCGGGATCACTCTCGGCATGGACGAGCTGTACAAG
```

*Bad Example 2*

```bash
$ cat mCherry.fa
>mCherry
ATGGTGAGCAAGGGCGAGGAGGATAACATGGCCATCATCAAGGAaTTtATGCGCTTCAAaGTtCACATGGAGGGCTCCGTGAACGGCCACGAGTTCGAGATCGAGGGCGAGGGCGAGGGCCGCCCCTACGAGGGCACCCAaACaGCCAAGCTGAAGGTtACCAAGGGTGGCCCCCTGCCCTTCGCCTGGGACATCCTGTCCCCTCAaTTtATGTAtGGCTCCAAGGCCTACGTGAAGCACCCCGCCGACATCCCCGACTACTTGAAGCTGTCCTTCCCCGAGGGCTTCAAGTGGGAGCGCGTGATGAACTTCGAGGACGGCGGCGTGGTGACCGTGACCCAGGACTCCTCCCTGCAaGACGGCGAGTTCATCTACAAaGTtAAGCTGCGgGGaACCAACTTCCCCTCCGACGGCCCCGTAATGCAGAAGAAGACCATGGGCTGGGAGGCCTCCTCCGAGCGGATGTACCCCGAGGACGGCGCCCTGAAGGGCGAGATCAAGCAGAGGCTGAAGCTGAAGGACGGCGGCCACTACGACGCTGAGGTCAAGACCACCTACAAGGCCAAGAAGCCCGTGCAGCTGCCCGGCGCCTACAACGTCAACATCAAGTTGGACATCACCTCCCACAACGAGGACTACACCATCGTGGAACAaTACGAACGCGCCGAGGGCCGCCACTCCACCGGCGGCATGGACGAGCTGTACAAG$
```

- Why: The sequence line does not end with a newline character (`\n`). Your bash prompt (i.e. `$`) is displayed at the end of the sequence when you run the `cat` command to display the contents of the file.
- How to correct: Add a new line character (`\n`) at the end of the sequence as shown below. Your bash prompt must show up at the next line when you run the `cat` command:

```bash
$ cat mCherry.fa
>mCherry
ATGGTGAGCAAGGGCGAGGAGGATAACATGGCCATCATCAAGGAaTTtATGCGCTTCAAaGTtCACATGGAGGGCTCCGTGAACGGCCACGAGTTCGAGATCGAGGGCGAGGGCGAGGGCCGCCCCTACGAGGGCACCCAaACaGCCAAGCTGAAGGTtACCAAGGGTGGCCCCCTGCCCTTCGCCTGGGACATCCTGTCCCCTCAaTTtATGTAtGGCTCCAAGGCCTACGTGAAGCACCCCGCCGACATCCCCGACTACTTGAAGCTGTCCTTCCCCGAGGGCTTCAAGTGGGAGCGCGTGATGAACTTCGAGGACGGCGGCGTGGTGACCGTGACCCAGGACTCCTCCCTGCAaGACGGCGAGTTCATCTACAAaGTtAAGCTGCGgGGaACCAACTTCCCCTCCGACGGCCCCGTAATGCAGAAGAAGACCATGGGCTGGGAGGCCTCCTCCGAGCGGATGTACCCCGAGGACGGCGCCCTGAAGGGCGAGATCAAGCAGAGGCTGAAGCTGAAGGACGGCGGCCACTACGACGCTGAGGTCAAGACCACCTACAAGGCCAAGAAGCCCGTGCAGCTGCCCGGCGCCTACAACGTCAACATCAAGTTGGACATCACCTCCCACAACGAGGACTACACCATCGTGGAACAaTACGAACGCGCCGAGGGCCGCCACTCCACCGGCGGCATGGACGAGCTGTACAAG
$
```

## Gene ID Prefix

`ensembleIdPrefix` must be set to either `ENS` or `ENSMUS`. For human + mouse hybrid, you have no choice but to either specify `ENS` or `ENSMUS` because the STAR aligner doesn't like any other prefix, and it doesn't even complain, but simply won't include the trangenes/reporter genes in the final annotation file.

## Outputs

- STAR index and `annotations.gtf` for SEQC.
- SEQC outputs if specified.
- FASTA/Index file for IGV visualization (`fa.gz` and `fa.gz.gzi`).

## How to Test

### GCP

```bash
./submit.sh \
    -k ~/secrets-gcp.json \
    -i ./config/SeqcCustomGenes.inputs.gcp.json \
    -l ./config/SeqcCustomGenes.labels.gcp.json \
    -o SeqcCustomGenes.options.gcp.json
```

### AWS

```bash
./submit.sh \
    -k ~/secrets-aws.json \
    -i ./config/Tp53_Rb_PtenGEMM-TKO12_week_1.inputs.aws.json \
    -l ./config/Tp53_Rb_PtenGEMM-TKO12_week_1.labels.aws.json \
    -o SeqcCustomGenes.options.aws.json
```

## Biotype Filtering

Only biotypes specified in `SeqcCustomGenes.biotypes` will be retained from the input GTF file (`SeqcCustomGenes.annotationGtf`):

```json
"SeqcCustomGenes.annotationGtf": "s3://seqc-public/genomes/mm38_long_polya/annotations.gtf",
"SeqcCustomGenes.biotypes": [
    "protein_coding",
    "lincRNA",
    "antisense",
    "IG_V_gene",
    "IG_D_gene",
    "IG_J_gene",
    "IG_C_gene",
    "TR_V_gene",
    "TR_D_gene",
    "TR_J_gene",
    "TR_C_gene"
],
```
