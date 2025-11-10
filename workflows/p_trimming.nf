include { fastqc_pre } from '../modules/fastqc.nf'
include { fastqc_post } from '../modules/fastqc.nf'

workflow pre_trimming_workflow {
    take:
    input_data

    main:
    fastqc_pre(input_data)

    emit:
    fastqc = fastqc_pre.out.fastqc_pre_result
}

workflow post_trimming_workflow {
    take:
    input_data

    main:
    fastqc_post(input_data)

    emit:
    fastqc = fastqc_post.out.fastqc_post_result
}