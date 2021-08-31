#!/usr/bin/env bash

java -jar ~/Applications/womtool.jar \
    validate \
    StarTransgenes.wdl \
    --inputs ./config/template.inputs.json
