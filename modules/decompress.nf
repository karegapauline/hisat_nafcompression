process DECOMPRESS {
    label 'decompress'
    publishDir params.outdir
    
    input:
    tuple val(name), path(reads)
	
    output:
    tuple val(name), path("${name}*fastq"), emit: decompressed_reads
	
    script:
    """
    unnaf --fastq ${reads[0]} > ${name}_1.trimmed.fastq
    unnaf --fastq ${reads[1]} > ${name}_2.trimmed.fastq
    
    
    """
    
   }
   
