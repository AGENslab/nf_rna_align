include { aligment_workflow } from './workflows/aligment.nf'
include { trimmed_workflow } from './workflows/aligment.nf'
include { preprocessing_workflow } from './workflows/preprocessing.nf'
include { pre_trimming_workflow } from './workflows/p_trimming.nf'
include { post_trimming_workflow } from './workflows/p_trimming.nf'

workflow {

    if (params.csv) {
        raw_data = Channel.fromPath(params.csv)
            | splitCsv(header: true)
            | map { row -> tuple(row.ID, row.forward, row.reverse) }
    } else {
        error "Error: Se requiere un archivo CSV válido en 'params.csv'."
    }

    ref_data = Channel.value(file("/mnt/beegfs/home/cherrera/AGENsLab/Sarcopenia/analysis/mrnaobj1/reference/Homo_sapiens.GRCh38.dna.primary_assembly.fa"))

    preprocessing_workflow(ref_data)

    pre_trimming_workflow(raw_data)

    trimmed_workflow(raw_data)

    post_trimming_workflow(trimmed_workflow.out.trimed)

    aligment_workflow(ref_data, trimmed_workflow.out.trimed, preprocessing_workflow.out.result)

}