# SEQC Custom Genes

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
    -i ./config/SeqcCustomGenes.inputs.aws.json \
    -l ./config/SeqcCustomGenes.labels.aws.json \
    -o SeqcCustomGenes.options.aws.json
```
