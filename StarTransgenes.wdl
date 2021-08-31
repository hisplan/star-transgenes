version 1.0

import "modules/FastaToGtf.wdl" as FastaToGtf
import "modules/CreateFullGtf.wdl" as CreateFullGtf
import "modules/STAR.wdl" as STAR
import "modules/GenomeForIgv.wdl" as GenomeForIgv
import "modules/FilterBiotypes.wdl" as FilterBiotypes

workflow StarTransgenes {

    input {
        File genomeReferenceFasta
        File annotationGtf
        Array[File] customFastaFiles
        Array[String] ensembleIds
        String ensembleIdPrefix

        Int sjdbOverhang = 101
        String starVersion
        Array[String] biotypes

        # docker-related
        String dockerRegistry
    }

    # zip FASTA files and Ensemble IDs
    # pair.left = path to FASTA file
    # pair.right = path to Ensemble ID (only digits)
    Array[Pair[File, String]] fastaAndEnsembleIds = zip(customFastaFiles, ensembleIds)

    scatter (pair in fastaAndEnsembleIds) {

        call FastaToGtf.IndexFasta {
            input:
                fasta = pair.left,
                dockerRegistry = dockerRegistry
        }

        # G for gene, T for transcript
        call FastaToGtf.IndexToGtf {
            input:
                fastaIdx = IndexFasta.out,
                geneId = ensembleIdPrefix + "G" + pair.right,
                transcriptId = ensembleIdPrefix + "T" + pair.right,
                dockerRegistry = dockerRegistry
        }
    }

    call GenomeForIgv.ConcatenateFastas {
        input:
            genomeReferenceFasta = genomeReferenceFasta,
            customFastaFiles = customFastaFiles,
            dockerRegistry = dockerRegistry
    }

    call GenomeForIgv.IndexCompressedFasta {
        input:
            compressedFasta = ConcatenateFastas.out,
            dockerRegistry = dockerRegistry
    }

    call CreateFullGtf.CreateFullGtf {
        input:
            normalFullGtf = annotationGtf,
            customGtfs = IndexToGtf.out
    }

    # add `transgene` to the user supplied biotypes
    call FilterBiotypes.FilterBiotypes {
        input:
            biotypes = flatten([biotypes, ["transgene"]]),
            gtf = CreateFullGtf.out,
            dockerRegistry = dockerRegistry
    }

    call STAR.GenerateIndex {
        input:
            genomeReferenceFasta = genomeReferenceFasta,
            customFasta = customFastaFiles,
            annotationGtf = FilterBiotypes.outGtf,
            sjdbOverhang = sjdbOverhang,
            starVersion = starVersion,
            dockerRegistry = dockerRegistry
    }

    output {
        Array[File] outStarFiles = GenerateIndex.outFiles
        File outFasta = ConcatenateFastas.out
        File outFastaGzi = IndexCompressedFasta.outGzi
        File outFastaFai = IndexCompressedFasta.outFai
        File outFilterLog = FilterBiotypes.outLog
    }
}
