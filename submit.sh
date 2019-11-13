#!/bin/bash

usage()
{
cat << EOF
USAGE: `basename $0` [options]
    -k  service account key (e.g. secrets.json)
    -l  labels file (e.g. labels.json)
    -o  options file (e.g. options.json)
EOF
}

while getopts "k:l:o:h" OPTION
do
    case $OPTION in
        k) service_account_key=$OPTARG ;;
        l) labels_file=$OPTARG ;;
        o) options_file=$OPTARG ;;
        h) usage; exit 1 ;;
        *) usage; exit 1 ;;
    esac
done

if [ -z "$service_account_key" ] || [ -z "$labels_file" ] || [ -z "$options_file" ]
then
    usage
    exit 1
fi

rm -rf SeqcCustomGenes.deps.zip
zip SeqcCustomGenes.deps.zip modules modules/*

cromwell-tools submit \
    --secrets-file ${service_account_key} \
    --wdl SeqcCustomGenes.wdl \
    --inputs-files SeqcCustomGenes.inputs.json \
    --deps-file SeqcCustomGenes.deps.zip \
    --label-file ${labels_file} \
    --options-file ${options_file}
