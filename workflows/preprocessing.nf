include { index_process } from '../modules/index.nf'

workflow preprocessing_workflow {
    take:
    index_data

    main:
    index_process(index_data)

    emit:
    result = index_process.out.index_output
}