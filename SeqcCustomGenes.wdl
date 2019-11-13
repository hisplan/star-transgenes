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

    Array[Pair[File, String]] fastaAndEnsembleIds = zip(customFastaFiles, ensembleIds)

    scatter (pair in fastaAndEnsembleIds) {

        call FastaToGtf.IndexFasta {
            input:
                fasta = pair.left
        }

        call FastaToGtf.IndexToGtf {
            input:
                fastaIdx = IndexFasta.out,
                ensembleId = ensembleIdPrefix + pair.right
        }
    }

    # scatter (fasta in customFastaFiles) {

    #     call FastaToGtf.IndexFasta {
    #         input:
    #             fasta = fasta
    #     }

    #     call FastaToGtf.IndexToGtf {
    #         input:
    #             fastaIdx = IndexFasta.out
    #     }
    # }

    call CreateFullGtf.CreateFullGtf {
        input:
            normalFullGtf = annotationGtf,
            customGtfs = IndexToGtf.out
    }

    # call STAR.GenerateIndex {
    #     input:
    #         genomeReferenceFasta = genomeReferenceFasta,
    #         customFasta = customFastaFiles,
    #         annotationGtf = annotationGtf
    # }

    # output {
    #     File newGtf = CreateFullGtf.out
    #     Array[File] outFiles = GenerateIndex.outFiles
    # }
}
