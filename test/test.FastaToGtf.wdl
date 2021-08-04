version 1.0

import "modules/FastaToGtf.wdl" as FastaToGtf

workflow FastaToGtf {

    input {
        File fasta
        String geneId
        String transcriptId

        # docker-related
        String dockerRegistry
    }

    call FastaToGtf.IndexFasta {
        input:
            fasta = fasta,
            dockerRegistry = dockerRegistry
    }

    call FastaToGtf.IndexToGtf {
        input:
            fastaIdx = IndexFasta.out,
            geneId = geneId,
            transcriptId = transcriptId,
            dockerRegistry = dockerRegistry
    }

    output {
        File fai = IndexFasta.out
        File gtf = IndexToGtf.out
    }
}
