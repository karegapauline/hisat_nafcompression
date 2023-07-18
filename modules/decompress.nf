process DECOMPRESS {
    label 'decompress'
    publishDir params.outdir
	
    input:
    tuple val(name), path(compressed_trimmed_reads)
	
    output:
    tuple val(name), path("${name}_*.trimmed.fastq"), emit: sample2_decompressed
	
    script:
    """
    unnaf --fastq ${compressed_trimmed_reads[0]} > ${name}_1.trimmed.fastq
    unnaf --fastq ${compressed_trimmed_reads[1]} > ${name}_2.trimmed.fastq
    
    
    """
    
   }
   
