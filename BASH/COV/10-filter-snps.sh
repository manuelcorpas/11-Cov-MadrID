#!/bin/sh
# variant calling performed using recalibrated (analysis-ready) bam

GATK_SOFT=/home/ec2-user/fs1/SOFTWARE/gatk-4.2.0.0
IN_DIR=/home/ec2-user/fs1/DATA/VCF
FASTA_REF=/home/ec2-user/fs1/DATA/FASTA/hg19/hg19.fa
OUT_DIR=/home/ec2-user/fs1/DATA/VCF


N=8
(
for file in $IN_DIR/*.snp.vcf
do
    ((i=i%N)); ((i++==0)) && wait

    fbname=$(basename "$file" | cut -d. -f1)

    $GATK_SOFT/gatk VariantFiltration \
        -V $file \
        -R $FASTA_REF \
        -O $OUT_DIR/$fbname.snp.out.vcf \
        -filter-name "QD_filter" \
        -filter "QD < 2.0" \
        -filter-name "FS_filter" \
        -filter "FS > 60.0" \
        -filter-name "MQ_filter" \
        -filter "MQ < 40.0" \
        -filter-name "SOR_filter" \
        -filter "SOR > 4.0" &
    #$GATK_SOFT/gatk SelectVariants -V $file -R $FASTA_REF -select-type INDEL -O $OUT_DIR/$fbname.indel.vcf &

done
)
