#!/bin/sh
# It recalibrates the base qualities of the input reads based on the recalibration table produced by the BaseRecalibrator tool, and outputs a recalibrated BAM or CRAM file.

GATK_SOFT=/home/ec2-user/fs1/SOFTWARE/gatk-4.2.0.0
BAM_DIR=/home/ec2-user/fs1/DATA/BAM.smpl
FASTA_REF=/home/ec2-user/fs1/DATA/FASTA/hg19/hg19.fa
GATK_OUT=/home/ec2-user/fs1/DATA/GATK


N=8
(
for file in $BAM_DIR/*.RG1.bam
do
    ((i=i%N)); ((i++==0)) && wait

    fbname=$(basename "$file" | cut -d. -f1)
    echo "$fbname"
    if [[ -f $BAM_DIR/$fbname.recal_data.table  ]]; then
        continue
    fi
    echo "$GATK_SOFT/gatk ApplyBQSR -I $file -R $FASTA_REF --bqsr-recal-file $GATK_OUT/$fbname.recal_data.table -O $GATK_OUT/$fbname.bam"

        $GATK_SOFT/gatk ApplyBQSR -I $file -R $FASTA_REF --bqsr-recal-file $GATK_OUT/$fbname.recal_data.table -O $GATK_OUT/$fbname.bam &
done
)
