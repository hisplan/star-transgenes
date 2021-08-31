#!/bin/bash -e

modules="FilterBiotypes GenomeForIgv FastaToGtf CreateFullGtf STAR"

for module_name in $modules
do

    echo "Testing ${module_name}..."
    
    ./run-test.sh -k ~/secrets-gcp.json -m ${module_name}

done
