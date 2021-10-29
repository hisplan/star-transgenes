#!/usr/bin/env bash

if [ -z $SCING_HOME ]
then
    echo "Environment variable 'SCING_HOME' not defined."
    exit 1
fi

java -jar ${SCING_HOME}/devtools/womtool.jar \
    validate \
    TransgenesSeqc.wdl \
    --inputs ./config/template.seqc.inputs.json

java -jar ${SCING_HOME}/devtools/womtool.jar \
    validate \
    TransgenesCellRanger.wdl \
    --inputs ./config/template.cellranger.inputs.json
