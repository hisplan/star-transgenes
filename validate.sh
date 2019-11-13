#!/usr/bin/env bash

java -jar ~/Applications/womtool.jar \
    validate \
    SeqcCustomGenes.wdl \
    --inputs SeqcCustomGenes.inputs.json
