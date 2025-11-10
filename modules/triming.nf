process fastp_trim {
    publishDir "${params.outdir_trimmed}", mode: 'copy', pattern: '*.fastq'

    input:
    tuple val(sample), path(read_1), path(read_2)

    output:
    tuple val(sample), path("${sample}_R1_trimmed.fastq"), path("${sample}_R2_trimmed.fastq"),
    emit: trimed_data

    script:
    """
    fastp \
        -i ${read_1} \
        -I ${read_2} \
        -o ${sample}_R1_trimmed.fastq \
        -O ${sample}_R2_trimmed.fastq \
        -h ${sample}_fastp.html \
        -j ${sample}_fastp.json \
        -w 4
    """
}