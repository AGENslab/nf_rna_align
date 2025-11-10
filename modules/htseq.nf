process htseq_count {
    publishDir "${params.outdir_htseq}", mode: 'copy', pattern: '*.txt'
    
    input:
    path bam

    output:
    path "${bam}_counts.txt"

    script:
    """
    htseq-count -f bam -s no -r pos ${bam} ${params.gtf} > ${bam}_counts.txt
    """
}