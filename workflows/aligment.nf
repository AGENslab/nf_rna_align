include { mem_process } from '../modules/mem.nf'
include { fastp_trim } from '../modules/triming.nf'

workflow trimmed_workflow {
    take:
    read_data

    main:
    fastp_trim(read_data)

    emit:
    trimed = fastp_trim.out.trimed_data 
}

workflow aligment_workflow {
    take:
    ref_data
    read_data
    index_data

    main:
    mem_process(ref_data, read_data, index_data)

    emit:
    result = mem_process.out.mem_output
}