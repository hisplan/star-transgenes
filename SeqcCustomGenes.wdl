version 1.0

import "modules/FastaToGtf.wdl" as FastaToGtf
import "modules/CreateFullGtf.wdl" as CreateFullGtf
import "modules/STAR.wdl" as STAR
import "modules/SEQC.wdl" as SEQC

workflow SeqcCustomGenes {

    input {
        File genomeReferenceFasta
        File annotationGtf
        Array[File] customFastaFiles
        Array[String] ensembleIds
        String ensembleIdPrefix

        # SEQC-related parameters
        Boolean SEQC_disabled = false
        String SEQC_version
        String SEQC_assay
        String SEQC_barcodeFiles
        String SEQC_genomicFastq
        String SEQC_barcodeFastq
        String SEQC_starArguments
        String SEQC_outputPrefix
        String SEQC_email
    }

    # zip FASTA files and Ensemble IDs
    # pair.left = path to FASTA file
    # pair.right = path to Ensemble ID (only digits)
    Array[Pair[File, String]] fastaAndEnsembleIds = zip(customFastaFiles, ensembleIds)

    scatter (pair in fastaAndEnsembleIds) {

        call FastaToGtf.IndexFasta {
            input:
                fasta = pair.left
        }

        # G for gene, T for transcript
        call FastaToGtf.IndexToGtf {
            input:
                fastaIdx = IndexFasta.out,
                geneId = ensembleIdPrefix + "G" + pair.right,
                transcriptId = ensembleIdPrefix + "T" + pair.right,
        }
    }

    call CreateFullGtf.CreateFullGtf {
        input:
            normalFullGtf = annotationGtf,
            customGtfs = IndexToGtf.out
    }

    call STAR.GenerateIndex {
        input:
            genomeReferenceFasta = genomeReferenceFasta,
            customFasta = customFastaFiles,
            annotationGtf = CreateFullGtf.out
    }

    # run only is not disabled
    if (SEQC_disabled == false) {
        # hack: SEQC only accepts a directory name for where annotations.gtf is placed
        call SEQC.GetDirectoryName {
            input:
                fullPathWithFileName = GenerateIndex.outFiles[0]
        }

        call SEQC.SEQC {
            input:
                version = SEQC_version,
                assay = SEQC_assay,
                index = GetDirectoryName.out,
                barcodeFiles = SEQC_barcodeFiles,
                genomicFastq = SEQC_genomicFastq,
                barcodeFastq = SEQC_barcodeFastq,
                starArguments = SEQC_starArguments,
                outputPrefix = SEQC_outputPrefix,
                email = SEQC_email
        }
    }

    output {
        Array[File] outStarFiles = GenerateIndex.outFiles
        Array[File]? outSeqcFiles = SEQC.outFiles
    }
}
