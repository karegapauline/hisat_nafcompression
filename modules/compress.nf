process COMPRESS {
    label 'compress'
    publishDir params.outdir
	
    input:
    tuple val(name), path(reads)
	
    output:
    tuple val(name), path("${name}_*.naf"), emit: sample_compressed
	
    script:
    """
    mkdir TMP
    ennaf ${reads[0]} -o ${name}_1.naf --temp-dir TMP
    ennaf ${reads[1]} -o ${name}_2.naf --temp-dir TMP
    
    
    """
    
   }
   