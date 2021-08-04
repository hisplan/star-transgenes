version 1.0

import "modules/GenomeForIgv.wdl" as GenomeForIgv

workflow GenomeForIgv {

    input {
        File genomeReferenceFasta
        Array[File] customFastaFiles

        # docker-related
        String dockerRegistry
    }

    call GenomeForIgv.ConcatenateFastas {
        input:
            genomeReferenceFasta = genomeReferenceFasta,
            customFastaFiles = customFastaFiles,
            dockerRegistry = dockerRegistry
    }

    call GenomeForIgv.IndexCompressedFasta {
        input:
            compressedFasta = ConcatenateFastas.out,
            dockerRegistry = dockerRegistry
    }

    output {
        File outFasta = ConcatenateFastas.out
        File outGzi = IndexCompressedFasta.outGzi
        File outFai = IndexCompressedFasta.outFai
    }
}
