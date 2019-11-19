version 1.0

task ConcatenateFastas {

    input {
        File genomeReferenceFasta
        Array[File] customFastaFiles
    }

    String outName = "customGenome.fa"
    String dockerImage = "hisplan/htslib:1.9"
    Float inputSize = size(genomeReferenceFasta, "GiB") + size(customFastaFiles, "GiB")
    Int numCores = 4

    command <<<
        set -euo pipefail

        # concatenate
        cat ~{genomeReferenceFasta} ~{sep=" " customFastaFiles} > ~{outName}

        # comrpess
        bgzip --threads ~{numCores} --index ~{outName}
    >>>

    output {
        File out = outName + ".gz"
    }

    runtime {
        docker: dockerImage
        disks: "local-disk " + ceil(2 * (if inputSize < 1 then 1 else inputSize )) + " HDD"
        cpu: numCores
        memory: "16 GB"
        preemptible: 0
    }
}

task IndexCompressedFasta {

    input {
        File compressedFasta
    }

    String baseName = basename(compressedFasta, ".fa.gz")

    String dockerImage = "hisplan/cromwell-samtools:1.9"
    Float inputSize = size(compressedFasta, "GiB")
    Int numCores = 1

    command <<<
        set -euo pipefail

        # workaround to make it easy for Cromwell to pick up .fa.fai
        # i.e. work from the current directory where Cromwell put you in
        cp ~{compressedFasta} ~{baseName}.fa.gz
        samtools faidx ~{baseName}.fa.gz
    >>>

    output {
        File outGzi = baseName + ".fa.gz.gzi"
        File outFai = baseName + ".fa.gz.fai"
    }

    runtime {
        docker: dockerImage
        disks: "local-disk " + ceil(2 * (if inputSize < 1 then 1 else inputSize )) + " HDD"
        cpu: numCores
        memory: "8 GB"
        preemptible: 0
    }
}
