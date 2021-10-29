version 1.0

import "modules/CellRanger.wdl" as CellRanger

workflow CellRanger {

    input {
        String referenceName
        File fasta
        File gtf
        String cellRangerVersion

        # docker-related
        String dockerRegistry
    }

    call CellRanger.mkref {
        input:
            referenceName = referenceName,
            fasta = fasta,
            gtf = gtf,
            cellRangerVersion = cellRangerVersion,
            dockerRegistry = dockerRegistry
    }

    output {
        File outReferencePackage = mkref.outReferencePackage
    }
}
