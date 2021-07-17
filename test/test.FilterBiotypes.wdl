version 1.0

import "modules/FilterBiotypes.wdl" as FilterBiotypes

workflow FilterBiotypes {

    input {
        Array[String] biotypes
        File gtf
    }

    # add `transgene` to the user supplied biotypes
    call FilterBiotypes.FilterBiotypes {
        input:
            biotypes = flatten([biotypes, ["transgene"]]),
            gtf = gtf
    }

    output {
        File outGtf = FilterBiotypes.outGtf
        File outLog = FilterBiotypes.outLog
    }
}
