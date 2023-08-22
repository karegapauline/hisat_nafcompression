process SAMTOOLS {
    label 'samtools'
    publishDir params.outdir
    
    input:
    tuple val(sample_name), path(sam_file), path(reference_genome)
    
    output:
    path("${sam_file}.sorted.cram"), emit: sample_cram 
    
    script:
    """
    samtools view -T ${reference_genome} -C -o ${sam_file}.sorted.cram ${sam_file}
    """
    
}

process SAMTOOLS_MERGE {
    label 'samtools'
    publishDir params.outdir

    input:
    file out_cram
    
    output:
    tuple val("alignement_gathered.cram"), path("alignement_gathered.cram"), emit: gathered_cram
    
    script:
    """
    samtools merge alignement_gathered.cram ${out_cram}
    """
}
