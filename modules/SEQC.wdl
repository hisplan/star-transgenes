version 1.0

task SEQC {

    input {
        String version
        String assay
        String index
        String barcodeFiles
        String genomicFastq
        String barcodeFastq
        String starArguments
        String outputPrefix
        String email

        Float inputSize = 250
        Int numCores = 8
        Int memoryGB = 64

        # docker-related
        String dockerRegistry
    }

    String dockerImage = dockerRegistry + "/cromwell-seqc:" + version

    command <<<
        set -euo pipefail

        # `--local` still requires AWS region to be speicifed
        export AWS_DEFAULT_REGION=us-east-1

        # run locally and do not terminate
        SEQC run ~{assay} \
            --index ~{index} \
            --barcode-files ~{barcodeFiles} \
            --genomic-fastq ~{genomicFastq} \
            --barcode-fastq ~{barcodeFastq} \
            --star-args ~{starArguments} \
            --output-prefix ~{outputPrefix} \
            --email ~{email} \
            --local --no-terminate
    >>>

    output {
        Array[File] outFiles = glob(outputPrefix + "*")
        File? outLog = "seqc_log.txt"
    }

    runtime {
        docker: dockerImage
        disks: "local-disk " + ceil(2 * (if inputSize < 1 then 1 else inputSize )) + " HDD"
        cpu: numCores
        memory: memoryGB + "GB"
        preemptible: 0
    }
}

task GetDirectoryName {

    input {
        String fullPathWithFileName
    }

    # from: gs://chunj-cromwell/cromwell-execution/SeqcCustomGenes/588c4511-a574-4b10-86ba-fc7567b59671/call-GenerateIndex/glob-20ebd8c9cf25515da3e6ce1213dba1ad/annotations.gtf
    # to:   gs://chunj-cromwell/cromwell-execution/SeqcCustomGenes/588c4511-a574-4b10-86ba-fc7567b59671/call-GenerateIndex/glob-20ebd8c9cf25515da3e6ce1213dba1ad/
    command <<<
        set -euo pipefail

        python - << EOF
        import os

        print(os.path.dirname("~{fullPathWithFileName}") + "/")
        EOF
    >>>

    output {
        String out = read_string(stdout())
    }

    # centos 7 comes with python (ubuntu not)
    # python docker cannot run because ENTRYPOINT issue in Cromwell
    runtime {
        docker: "centos:7"
        cpu: 1
        memory: "1 GB"
    }
}
