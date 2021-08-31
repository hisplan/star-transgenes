# STAR Transgenes

Creating a genome index for the STAR aligner with transgenes

## Setup

The pipeline is a part of SCING (Single-Cell pIpeliNe Garden; pronounced as "sing" /siŋ/). For setup, please refer to [this page](https://github.com/hisplan/scing). All the instructions below is given under the assumption that you have already configured SCING in your environment.

## Create Job Files

You need two files - one inputs file and one labels file. Use the following example files to help you create your job file:

- `config/template.inputs.json`
- `config/template.labels.json`

### Inputs

#### Input FASTA File Requirements

Please refer to to the document [here](./docs/user-instructions.md).

#### Gene ID Prefix

`ensembleIdPrefix` must be set to either `ENS` or `ENSMUS`. For human + mouse hybrid, you have no choice but to either specify `ENS` or `ENSMUS` because the STAR aligner doesn't like any other prefix, and it doesn't even complain, but simply won't include the trangenes/reporter genes in the final annotation file.

#### Biotype Filtering

Only biotypes specified in `StarTransgenes.biotypes` will be retained from the input GTF file (`StarTransgenes.annotationGtf`):

```json
"StarTransgenes.annotationGtf": "s3://seqc-public/genomes/mm38_long_polya/annotations.gtf",
"StarTransgenes.biotypes": [
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

#### References

You need to specify the standard reference genome and gene annotation file:

Ensembl 85ish (Human):

```json
"StarTransgenes.genomeReferenceFasta": "s3://dp-lab-home/chunj/seqc-custom-genes/Ensembl-85ish/hg38.fa",
"StarTransgenes.annotationGtf": "s3://seqc-public/genomes/hg38_long_polya/annotations.gtf",
```

Ensembl 85ish (Mouse):

```json
"StarTransgenes.genomeReferenceFasta": "s3://dp-lab-home/chunj/seqc-custom-genes/Ensembl-85ish/mm38.fa",
"StarTransgenes.annotationGtf": "s3://seqc-public/genomes/mm38_long_polya/annotations.gtf",
```

Ensembl 100 (Human):

```json
"StarTransgenes.genomeReferenceFasta": "s3://dp-lab-home/chunj/seqc-custom-genes/Ensembl-100/homo_sapiens.fa",
"StarTransgenes.annotationGtf": "s3://dp-lab-home/chunj/seqc-custom-genes/Ensembl-100/homo_sapiens.gtf",
```

Ensembl 100 (Mouse):

```json
"StarTransgenes.genomeReferenceFasta": "s3://dp-lab-home/chunj/seqc-custom-genes/Ensembl-100/mus_musculus.fa",
"StarTransgenes.annotationGtf": "s3://dp-lab-home/chunj/seqc-custom-genes/Ensembl-100/mus_musculus.gtf",
```

## Submit Your Job

```bash
conda activate scing

./submit.sh \
    -k ~/keys/cromwell-secrets.json \
    -i configs/sample.inputs.json \
    -l configs/sample.labels.json \
    -o StarTransgenes.options.aws.json
```

## Outputs

- STAR index and `annotations.gtf` for SEQC.
- GTF filter log if only certain biotypes were kept.
- FASTA/Index file for IGV visualization (`fa.gz` and `fa.gz.gzi`).
