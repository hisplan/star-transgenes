version 1.0

import "modules/Transgenes.wdl" as Transgenes

workflow Transgenes {

    input {
        File genomeReferenceFasta
        File annotationGtf
        Array[File] customFastaFiles
        Array[String] ensembleIds
        String ensembleIdPrefix
        Array[String] biotypes

        # docker-related
        String dockerRegistry
    }

    call Transgenes.Transgenes {
        input:
            genomeReferenceFasta = genomeReferenceFasta,
            annotationGtf = annotationGtf,
            customFastaFiles = customFastaFiles,
            ensembleIds = ensembleIds,
            ensembleIdPrefix = ensembleIdPrefix,
            biotypes = biotypes,
            dockerRegistry = dockerRegistry
    }

    output {
        File outFasta = Transgenes.outFasta
        File outFastaBgzip = Transgenes.outFastaBgzip
        File outFastaGzi = Transgenes.outFastaGzi
        File outFastaFai = Transgenes.outFastaFai
        File outFilterLog = Transgenes.outFilterLog
    }
}
