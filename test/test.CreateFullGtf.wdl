version 1.0

import "modules/CreateFullGtf.wdl" as CreateFullGtf

workflow CreateFullGtf {

    input {
        File normalFullGtf
        Array[File] customGtfs
    }

    call CreateFullGtf.CreateFullGtf {
        input:
            normalFullGtf = normalFullGtf,
            customGtfs = customGtfs
    }

    output {
        File out = CreateFullGtf.out
    }
}
