#!/bin/bash -e

modules="GenomeForIgv FastaToGtf CreateFullGtf STAR SEQC"

for module_name in $modules
do

    echo "Testing ${module_name}..."
    
    ./run-test.sh -k ~/secrets-gcp.json -m ${module_name}

done
