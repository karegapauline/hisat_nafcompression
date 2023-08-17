process COMPRESS {
    label 'compress'
    publishDir params.outdir
    
    input:
    tuple val(name), path(reads)
	
    output:
    tuple val(name), path("${name}*.naf"), emit: compressed_reads
	
    script:
    """
    mkdir mytemp
    ennaf -o ${name}_1.trimmed.naf --temp-dir mytemp ${reads[0]} 
    ennaf -o ${name}_2.trimmed.naf --temp-dir mytemp ${reads[1]} 
    
    
    """
    
   }
   