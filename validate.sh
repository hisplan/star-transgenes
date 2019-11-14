#!/usr/bin/env bash

java -jar ~/Applications/womtool.jar \
    validate \
    SeqcCustomGenes.wdl \
    --inputs ./config/SeqcCustomGenes.inputs.aws.json
