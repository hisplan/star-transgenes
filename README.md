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

## Input Requirements

### User Instructions

Please refer to to the document [here](./docs/user-instructions.md).

### Gene ID Prefix

`ensembleIdPrefix` must be set to either `ENS` or `ENSMUS`. For human + mouse hybrid, you have no choice but to either specify `ENS` or `ENSMUS` because the STAR aligner doesn't like any other prefix, and it doesn't even complain, but simply won't include the trangenes/reporter genes in the final annotation file.

### Biotype Filtering

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

## Outputs

- STAR index and `annotations.gtf` for SEQC.
- GTF filter log if only certain biotypes were kept.
- SEQC outputs if specified (TBD).
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
