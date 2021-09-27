#!/bin/sh
# variant calling performed using recalibrated (analysis-ready) bam

SNPEFF=/home/ec2-user/fs1/SOFTWARE/snpEff
IN_DIR=/home/ec2-user/fs1/DATA/VCF
FASTA_REF=/home/ec2-user/fs1/DATA/FASTA/hg19/hg19.fa
OUT_DIR=/home/ec2-user/fs1/DATA/VCF


N=8
(
for file in $IN_DIR/*.snp.out.vcf
do
    ((i=i%N)); ((i++==0)) && wait

    fbname=$(basename "$file" | cut -d. -f1)

    java -jar $SNPEFF/snpEff.jar -v GRCh37.75 $file > $OUT_DIR/$fbname.snp.ann.vcf &

done
)
