version 1.0

task CreateFullGtf {

    input {
        File normalFullGtf
        Array[File] cutomGtfs
    }

    String outName = "custom-annotations.gtf"
    Float inputSize = size(normalFullGtf, "GiB")
    Int numCores = 1

    command <<<
        set -euo pipefail

        cat ~{normalFullGtf} ~{sep=" " cutomGtfs} > ~{outName}
    >>>

    output {
        File out = outName
    }

    runtime {
        docker: "ubuntu:18.04"
        disks: "local-disk " + ceil(2 * (if inputSize < 1 then 1 else inputSize )) + " HDD"
        cpu: numCores
        memory: "8 GB"
        preemptible: 0
    }
}
