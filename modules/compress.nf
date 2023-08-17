process COMPRESS {
    label 'compress'
    publishDir params.outdir
    
    input:
    tuple val(name), path(reads)
	
    output:
    tuple val(name), path("${name}*.naf"), emit: compressed_reads
	
    script:
    """
    ennaf  ${reads[0]} -o ${name}_1.naf --temp-dir .
    ennaf  ${reads[1]} -o ${name}_2.naf --temp-dir .
    
    
    """
    
   }
   