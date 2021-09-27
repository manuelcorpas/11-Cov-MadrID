#!/bin/sh
# variant calling performed using recalibrated (analysis-ready) bam

GATK_SOFT=/home/ec2-user/fs1/SOFTWARE/gatk-4.2.0.0
IN_DIR=/home/ec2-user/fs1/DATA/VCF
FASTA_REF=/home/ec2-user/fs1/DATA/FASTA/hg19/hg19.fa
OUT_DIR=/home/ec2-user/fs1/DATA/VCF


N=8
(
for file in $IN_DIR/*.raw.vcf
do
    ((i=i%N)); ((i++==0)) && wait

    fbname=$(basename "$file" | cut -d. -f1)

    echo "$GATK_SOFT/gatk SelectVariants -V $file -R $FASTA_REF -select-type SNP -O $OUT_DIR/$fbname.snp.vcf &"
    echo "$GATK_SOFT/gatk SelectVariants -V $file -R $FASTA_REF -select-type INDEL -O $OUT_DIR/$fbname.indel.vcf &"

    $GATK_SOFT/gatk SelectVariants -V $file -R $FASTA_REF -select-type SNP -O $OUT_DIR/$fbname.snp.vcf &
    $GATK_SOFT/gatk SelectVariants -V $file -R $FASTA_REF -select-type INDEL -O $OUT_DIR/$fbname.indel.vcf &

done
)
