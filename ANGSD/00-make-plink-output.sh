#!/bin/sh

DIR=$(pwd)
INDIR=$DIR/ANGSD
OUTDIR=/home/ec2-user/fs1/DATA/ANGSD
ANGSD=/home/ec2-user/fs1/SOFTWARE/angsd/angsd
BAMFOLDER1=/home/ec2-user/fs1/DATA/GATK
BAMFOLDER2=/home/ec2-user/fs1/DATA/1000G/BAM
find $BAMFOLDER1 | grep bam$ > $INDIR/angsd.filelist1
find $BAMFOLDER2 | grep bam$ > $INDIR/angsd.filelist2

$ANGSD  -bam $INDIR/angsd.filelist1 -out $OUTDIR/COV -doPlink 2 -doGeno -4 -doPost 1 -doMajorMinor 1 -GL 1 -doCounts 1 -doMaf 2 -postCutoff 0.99  -SNP_pval 1e-6 -geno_minDepth 4 &

$ANGSD  -bam $INDIR/angsd.filelist2 -out $OUTDIR/IBS -doPlink 2 -doGeno -4 -doPost 1 -doMajorMinor 1 -GL 1 -doCounts 1 -doMaf 2 -postCutoff 0.99  -SNP_pval 1e-6 -geno_minDepth 4 &


