version 1.0

import "modules/FastaToGtf.wdl" as FastaToGtf

workflow FastaToGtf {

    input {
        File fasta
        String geneId
        String transcriptId
    }

    call FastaToGtf.IndexFasta {
        input:
            fasta = fasta
    }

    call FastaToGtf.IndexToGtf {
        input:
            fastaIdx = IndexFasta.out,
            geneId = geneId,
            transcriptId = transcriptId
    }

    output {
        File fai = IndexFasta.out
        File gtf = IndexToGtf.out
    }
}
