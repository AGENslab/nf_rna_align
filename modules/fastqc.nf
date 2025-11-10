process fastqc_pre {
    publishDir "${params.outdir_fastqc}", mode: 'copy', pattern: '*.html'
    publishDir "${params.outdir_fastqc}", mode: 'copy', pattern: '*.zip'

    input:
    tuple val(sample), path(r1), path(r2)

    output:
    tuple path("${sample}*_fastqc.html"), path("${sample}*_fastqc.zip"),
    emit: fastqc_pre_result

    script:
    if (params.debug) {
        """
        echo ${r1} - ${r2} > ${sample}.txt
        """
    } else{
        """
        fastqc  ${r1} ${r2}
        """
    }
}

process fastqc_post {
    publishDir "${params.outdir_fastqc_trim}", mode: 'copy', pattern: '*.html'
    publishDir "${params.outdir_fastqc_trim}", mode: 'copy', pattern: '*.zip'

    input:
    tuple val(sample), path(r1), path(r2)

    output:
    tuple path("${sample}*_fastqc.html"), path("${sample}*_fastqc.zip"),
    emit: fastqc_post_result

    script:
    if (params.debug) {
        """
        echo ${r1} - ${r2} > ${sample}.txt
        """
    } else{
        """
        fastqc  ${r1} ${r2}
        """
    }
}