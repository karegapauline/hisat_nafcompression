
nextflow.enable.dsl = 2


include { COMPRESS } from './modules/compress.nf'
include { DECOMPRESS } from './modules/decompress.nf'
include { FASTP } from './modules/fastp.nf'
include { CHECK_STRANDNESS } from './modules/check_strandness.nf'
include { HISAT2_INDEX_REFERENCE ; HISAT2_INDEX_REFERENCE_MINIMAL ; HISAT2_ALIGN ; EXTRACT_SPLICE_SITES ; EXTRACT_EXONS } from './modules/hisat2.nf'
include { SAMTOOLS ; SAMTOOLS_MERGE } from './modules/samtools.nf'
include { CUFFLINKS } from './modules/cufflinks.nf'

log.info """\
         RNAseq analysis using NextFlow 
         =============================
         genome: ${params.reference_genome}
         annot : ${params.reference_annotation}
         reads : ${params.reads}
         outdir: ${params.outdir}
         """
         .stripIndent()
 
params.outdir = 'results'

workflow {
    read_pairs_ch = channel.fromFilePairs( params.reads, checkIfExists: true ) 
    strand_ch = CHECK_STRANDNESS( read_pairs_ch, params.reference_cdna, params.reference_annotation_ensembl )
    strand_ch.view()
    FASTP( read_pairs_ch )
    COMPRESS(FASTP.out.sample_trimmed)
    decompressed_reads_ch = DECOMPRESS(COMPRESS.out)
    if (params.mode == "minimum_genome_build") {
       HISAT2_INDEX_REFERENCE_MINIMAL( params.reference_genome )
       HISAT2_ALIGN( decompressed_reads_ch, HISAT2_INDEX_REFERENCE_MINIMAL.out, CHECK_STRANDNESS.out.first() )}
    if (params.mode == "exon_splice_site") {
        EXTRACT_EXONS( params.reference_annotation )
        EXTRACT_SPLICE_SITES( params.reference_annotation )
        HISAT2_INDEX_REFERENCE( params.reference_genome, EXTRACT_EXONS.out, EXTRACT_SPLICE_SITES.out )
    HISAT2_ALIGN( decompressed_reads_ch, HISAT2_INDEX_REFERENCE.out, CHECK_STRANDNESS.out.first() )
   }
    SAMTOOLS( HISAT2_ALIGN.out.sample_sam, params.reference_genome )
    CUFFLINKS( CHECK_STRANDNESS.out, SAMTOOLS.out.sample_cram, params.reference_annotation )
} 
