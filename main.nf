include { INDEX } from './modules/salmon' 
include { FASTQC } from './modules/QC'

params.reads = "$baseDir/data/ggal/gut_{1,2}.fq"
params.transcriptome_file = "$projectDir/data/ggal/transcriptome.fa"
params.multiqc = "$projectDir/multiqc"
params.outdir = "results"


process QUANTIFICATION {
    input:
    path salmon_index
    tuple val(sample_id), path(reads)

    output:
    path "$sample_id"

    script:
    """
    salmon quant --threads $task.cpus --libType=U -i $salmon_index -1 ${reads[0]} -2 ${reads[1]} -o $sample_id
    """
}


workflow {
    Channel
        .fromFilePairs(params.reads, checkIfExists: true)
        .set { read_pairs_ch }
        INDEX(params.transcriptome_file)
            .set{ index_ch }
        QUANTIFICATION(index_ch, read_pairs_ch)
            .set{ quant_ch }
        FASTQC(read_pairs_ch)


}