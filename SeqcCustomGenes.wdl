version 1.0

import "modules/FastaToGtf.wdl" as FastaToGtf
import "modules/CreateFullGtf.wdl" as CreateFullGtf
import "modules/STAR.wdl" as STAR

workflow SeqcCustomGenes {

    input {
        File genomeReferenceFasta
        File annotationGtf
        Array[File] customFastaFiles
        Array[String] ensembleIds
        String ensembleIdPrefix
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

    output {
        File newGtf = CreateFullGtf.out
        Array[File] outFiles = GenerateIndex.outFiles
    }
}
