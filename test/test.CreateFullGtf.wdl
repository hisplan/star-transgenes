version 1.0

import "modules/CreateFullGtf.wdl" as CreateFullGtf

workflow CreateFullGtf {

    input {
        File normalFullGtf
        Array[File] cutomGtfs
    }

    call CreateFullGtf.CreateFullGtf {
        input:
            normalFullGtf = normalFullGtf,
            cutomGtfs = cutomGtfs
    }

    output {
        File out = CreateFullGtf.out
    }
}
