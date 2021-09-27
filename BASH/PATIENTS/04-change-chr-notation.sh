#!/bin/sh
GATK_SOFT=/home/ec2-user/fs1/SOFTWARE/gatk-4.2.0.0
BAM_DIR=/home/ec2-user/fs1/DATA/BAM.smpl
FASTA_REF=/home/ec2-user/fs1/DATA/FASTA/hg19/hg19.fa
GATK_OUT=/home/ec2-user/fs1/DATA/GATK


for file in $GATK_OUT/1000G-phase1-indels-b37.vcf  $GATK_OUT/1000G_phase3_v4_20130502-sites.vcf  $GATK_OUT/Mills_and_1000G_gold_standard-indels-b37.vcf
do
    fbname=$(basename "$file" | cut -d. -f1)
awk '{
    if($0 !~ /^#/)
    print "chr"$0;
    else if(match($0,/(##contig=<ID=)(.*)/,m))
    print m[1]"chr"m[2];
    else print $0
}' $file > $GATK_OUT/$fbname.with_chr.vcf
done
