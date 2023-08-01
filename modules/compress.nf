process COMPRESS {
    label 'compress'
    publishDir params.outdir
	
    input:
    tuple val(name), path(trimmed_reads)
	
    output:
    tuple val(name), path("${name}_*.trimmed.naf"), emit: sample2_compressed
	
    script:
    """
    mkdir mytemp
    ennaf -o ${name}_1.trimmed.naf --temp-dir mytemp ${trimmed_reads[0]} 
    ennaf -o ${name}_2.trimmed.naf --temp-dir mytemp ${trimmed_reads[1]} 
    
    
    """
    
   }
   