version 1.0

import "modules/GenomeForIgv.wdl" as GenomeForIgv

workflow GenomeForIgv {

    input {
        File genomeReferenceFasta
        Array[File] customFastaFiles
    }

    call GenomeForIgv.ConcatenateFastas {
        input:
            genomeReferenceFasta = genomeReferenceFasta,
            customFastaFiles = customFastaFiles
    }

    call GenomeForIgv.IndexCompressedFasta {
        input:
            compressedFasta = ConcatenateFastas.out
    }

    output {
        File outFasta = ConcatenateFastas.out
        File outGzi = IndexCompressedFasta.outGzi
        File outFai = IndexCompressedFasta.outFai
    }
}
