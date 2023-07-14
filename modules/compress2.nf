process COMPRESS2 {
    label 'compress2'
    publishDir params.outdir
	
    input:
    tuple val(name), path(trimmed_reads)
	
    output:
    tuple val(name), path("${name}_*.trimmed.naf"), emit: sample2_compressed
	
    script:
    """
    mkdir TMP
    ennaf ${trimmed_reads[0]} -o ${name}_1.trimmed.naf --temp-dir TMP
    ennaf ${trimmed_reads[1]} -o ${name}_2.trimmed.naf --temp-dir TMP
    
    
    """
    
   }
   