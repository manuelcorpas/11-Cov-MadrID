#!/bin/sh
# variant calling performed using recalibrated (analysis-ready) bam

GATK_SOFT=/home/ec2-user/fs1/SOFTWARE/gatk-4.2.0.0
IN_DIR=/home/ec2-user/fs1/DATA/1000G/BAM
FASTA_REF=/home/ec2-user/fs1/DATA/FASTA/hg19/hg19.fa.gz
OUT_DIR=/home/ec2-user/fs1/1000G/VCF


N=8
(
for file in $IN_DIR/*.bam
do
    ((i=i%N)); ((i++==0)) && wait

    fbname=$(basename "$file" | cut -d. -f1)

    echo "$GATK_SOFT/gatk HaplotypeCaller -I $file -R $FASTA_REF -O $OUT_DIR/$fbname.raw.vcf &"

    $GATK_SOFT/gatk HaplotypeCaller -I $file -R $FASTA_REF -O $OUT_DIR/$fbname.raw.vcf &

done
)
