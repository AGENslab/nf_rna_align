process mem_process {
    publishDir "${params.outdir}", mode: 'copy', pattern: '*.bam'

    input:
    path ref
    tuple val(sample), path(read_1), path(read_2)
    tuple path(amb), path(ann), path(bwt), path(pac), path(sa)

    output:
    path("${sample}.bam"),
    emit: mem_output

    script:
    if (params.debug) {
        """
        echo ${ref} - ${read_1}, ${read_2} > ${sample}.bam
        """
    } else{
        """
        bwa mem -t 8 ${ref} ${read_1} ${read_2} \
            | samtools view -bS - > ${sample}.bam
        """
    }
}