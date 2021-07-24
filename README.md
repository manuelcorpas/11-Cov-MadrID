# CoV-MadrID
Study of severe COVID-19 patients from first wave of COVID infections in Madrid (April 2020)

### How to run this
```
cd /home/ec2-user/fs1/CoV-MadrID/
perl PERL/01-FASTQ-2-SAM.pl
sh BASH/00-sam-2-bam.sh
```
This one run it on t3a.2xlarge. You can then run in parallel in 8 screen windows
```
sh BASH/01-sort-bam.sh
```
Test Picard
```
java -jar /mnt/efs/fs1/SOFTWARE/picard.jar -h
```
Create FASTA DICT
```
java -jar ../../../SOFTWARE/picard.jar CreateSequenceDictionary R= hg19.fa O= hg19.dict
```
Sort SAM files
```
Sort SAM files

java -jar picard.jar SortSam \
CREATE_INDEX=true \
INPUT=<input.bam> \
OUTPUT=<output.bam> \
SORT_ORDER=coordinate \
VALIDATION_STRINGENCY=STRICT
```
Merge BAM files
```
java -jar /mnt/efs/fs1/SOFTWARE/picard.jar MergeSamFiles ASSUME_SORTED=false CREATE_INDEX=true  I=../DATA/BAM/H23VNDRXY_1_8-UDI-kapa.sorted.bam I=../DATA/BAM/H23VNDRXY_2_8-UDI-kapa.sorted.bam I=../DATA/BAM/HWM7MDRXX_1_8-UDI-kapa.sorted.bam I=../DATA/BAM/HWM7MDRXX_2_8-UDI-kapa.sorted.bam MERGE_SEQUENCE_DICTIONARIES=false OUTPUT=../DATA/BAM.smpl/AR5463.merged.bam SORT_ORDER=coordinate USE_THREADING=true                     VALIDATION_STRINGENCY=STRICT
```
Mark Duplicates
```
java -jar /mnt/efs/fs1/SOFTWARE/picard.jar MarkDuplicates CREATE_INDEX=true INPUT=../DATA/BAM.smpl/AR5463.merged.bam VALIDATION_STRINGENCY=STRICT O=../DATA/BAM.smpl/AR5463.marked_duplicates.bam M=../DATA/BAM.smpl/AR5463.marked_dup_metrics.txt TMP_DIR=../DATA/tmp
```
Base Calibrator
```
/home/ec2-user/fs1/SOFTWARE/gatk-4.2.0.0/gatk BaseRecalibrator -I *.marked_duplicates.bam -R /home/ec2-user/fs1/DATA/FASTA/hg19/hg19.fa --known-sites /home/ec2-user/fs1/DATA/GATK/1000G_phase1.indels.b37.vcf.gz --known-sites /home/ec2-user/fs1/DATA/GATK/1000G_phase3_v4_20130502.sites.vcf.gz --known-sites /  Mills_and_1000G_gold_standard.indels.b37.vcf.gz -O /home/ec2-user/fs1/DATA/GATK/*.recal_data.table
```
Haplotype caller
```
gatk HaplotypeCaller \
        -R ref.fa \
        -I recal_reads.bam \
        -O raw_variants_recal.vcf
```
Extract SNPs and Indels
```
gatk SelectVariants \
        -R ref.fa \ 
        -V raw_variants_recal.vcf \
        -select-type SNP \
        -O raw_snps_recal.vcf

gatk SelectVariants \
        -R ref.fa \ 
        -V raw_variants.vcf \
        -select-type INDEL \
        -O raw_indels_recal.vcf
```
