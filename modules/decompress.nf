process DECOMPRESS {
    label 'decompress'
    publishDir params.outdir
	
    input:
    tuple val(name), path(compressed_reads)
	
    output:
    tuple val(name), path("${name}_*.fastq"), emit: sample_decompressed
	
    script:
    """
    unnaf --fastq ${compressed_reads[0]} > ${name}_1.fastq
    unnaf --fastq ${compressed_reads[1]} > ${name}_2.fastq
    
    
    """
    
   }
   