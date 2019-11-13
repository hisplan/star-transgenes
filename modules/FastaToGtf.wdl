version 1.0

task IndexFasta {

    input {
        File fasta
    }

    String baseName = basename(fasta, ".fa")

    String dockerImage = "hisplan/cromwell-samtools:1.9"
    Float inputSize = size(fasta, "GiB")
    Int numCores = 1

    command <<<
        set -euo pipefail

        # workaround to make it easy for Cromwell to pick up .fa.fai
        # i.e. work from the current directory where Cromwell put you in
        cp ~{fasta} ~{baseName}.fa
        samtools faidx ~{baseName}.fa
    >>>

    output {
        File out = baseName + ".fa.fai"
    }

    runtime {
        docker: dockerImage
        disks: "local-disk " + ceil(2 * (if inputSize < 1 then 1 else inputSize )) + " HDD"
        cpu: numCores
        memory: "8 GB"
        preemptible: 0
    }
}

task IndexToGtf {

    input {
        File fastaIdx
        String geneId
        String transcriptId
    }

    String outName = basename(fastaIdx, ".fa.fai") + ".gtf"

    String dockerImage = "hisplan/cromwell-fai2gtf:0.1"
    Float inputSize = size(fastaIdx, "GiB")
    Int numCores = 1

    command <<<
        set -euo pipefail

        python3 /opt/fai2gtf.py \
            --fai ~{fastaIdx} \
            --gene-id ~{geneId} \
            --transcript-id ~{transcriptId} \
            | tee ~{outName}
    >>>

    output {
        File out = outName
    }

    runtime {
        docker: dockerImage
        disks: "local-disk " + ceil(2 * (if inputSize < 1 then 1 else inputSize )) + " HDD"
        cpu: numCores
        memory: "8 GB"
        preemptible: 0
    }
}
