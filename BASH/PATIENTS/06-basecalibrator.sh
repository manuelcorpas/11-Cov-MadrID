#!/bin/sh
GATK_SOFT=/home/ec2-user/fs1/SOFTWARE/gatk-4.2.0.0
BAM_DIR=/home/ec2-user/fs1/DATA/BAM.smpl
FASTA_REF=/home/ec2-user/fs1/DATA/FASTA/hg19/hg19.fa
GATK_OUT=/home/ec2-user/fs1/DATA/GATK

#/home/ec2-user/fs1/SOFTWARE/gatk-4.2.0.0/gatk BaseRecalibrator -I *.RG1.bam -R /home/ec2-user/fs1/DATA/FASTA/hg19/hg19.fa --known-sites /home/ec2-user/fs1/DATA/GATK/1000G_phase1-indels-b37.vcf.gz --known-sites /home/ec2-user/fs1/DATA/GATK/1000G_phase3_v4_20130502-sites.vcf.gz --known-sites /  Mills_and_1000G_gold_standard-indels-b37.vcf.gz -O /home/ec2-user/fs1/DATA/GATK/*.recal_data.table

N=16
(
for file in $BAM_DIR/*.RG1.bam
do
    ((i=i%N)); ((i++==0)) && wait

    fbname=$(basename "$file" | cut -d. -f1)
    echo "$fbname"
    if [[ -f $BAM_DIR/$fbname.recal_data.table  ]]; then
        continue
    fi
    echo "$GATK_SOFT/gatk BaseRecalibrator -I $file -R $FASTA_REF \
        --known-sites $GATK_OUT/1000G-phase1-indels-b37.with_chr.vcf \
        --known-sites $GATK_OUT/1000G_phase3_v4_20130502-sites.with_chr.vcf \
        --known-sites $GATK_OUT/Mills_and_1000G_gold_standard-indels-b37.with_chr.vcf \
        -O $GATK_OUT/$fbname.recal_data.table"

    $GATK_SOFT/gatk BaseRecalibrator \
        -I $file \
        -R $FASTA_REF \
        --known-sites $GATK_OUT/1000G-phase1-indels-b37.with_chr.vcf \
        --known-sites $GATK_OUT/1000G_phase3_v4_20130502-sites.with_chr.vcf \
        --known-sites $GATK_OUT/Mills_and_1000G_gold_standard-indels-b37.with_chr.vcf \
        -O $GATK_OUT/$fbname.recal_data.table \
        &
done
)
