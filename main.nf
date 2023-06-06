params.reads = "$baseDir/data/ggal/gut_{1,2}.fq"
params.transcriptome_file = "$baseDir/data/ggal/transcriptome.fa"
params.multiqc = "$baseDir/multiqc"

process INDEX {


    input:
    path transcriptome

    output:
    path 'indexed_ref'

    script:
    """
    salmon index -t $transcriptome -i indexed_ref
    """

}

workflow {
    index_ch = INDEX(file(params.transcriptome_file))
}