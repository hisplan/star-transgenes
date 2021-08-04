version 1.0

import "modules/STAR.wdl" as STAR

workflow STAR {

    input {
        File genomeReferenceFasta
        Array[File] customFasta
        File annotationGtf
        Int sjdbOverhang
        String starVersion

        # docker-related
        String dockerRegistry
    }

    call STAR.GenerateIndex {
        input:
            genomeReferenceFasta = genomeReferenceFasta,
            customFasta = customFasta,
            annotationGtf = annotationGtf,
            sjdbOverhang = sjdbOverhang,
            starVersion = starVersion,
            dockerRegistry = dockerRegistry
    }

    output {
        Array[File] outFiles = GenerateIndex.outFiles
    }
}
