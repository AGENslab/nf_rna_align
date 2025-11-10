process index_process {

    input:
    path index_data

    output:
    tuple path("${index_data}.amb"), path("${index_data}.ann"), path("${index_data}.bwt"), path("${index_data}.pac"), path("${index_data}.sa"),
    emit: index_output

    script:
    if (params.debug) {
        """
        echo ${index_data}
        """
    } else{
        """
        bwa index ${index_data}
        """
    }
}