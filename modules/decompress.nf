process DECOMPRESS {
    label 'decompress'
    publishDir params.outdir
    
    input:
    tuple val(name), path(reads)
	
    output:
    tuple val(name), path("${name}*fastq"), emit: decompressed_reads
	
    script:
    """
    unnaf ${reads[0]} -o  ${name}_1.fastq
    unnaf ${reads[1]} -o  ${name}_2.fastq
    
    
    """
    
   }
   
