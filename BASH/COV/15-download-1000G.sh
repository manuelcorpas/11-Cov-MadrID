#!/bin/sh
# variant calling performed using recalibrated (analysis-ready) bam

IN_DIR=/home/ec2-user/fs1/DATA/1000G/VCF


N=8
(
for file in ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr10.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz/
        ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr10.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi/
        ftp ://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr11.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz/
        ftp://ftp.1 000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr11.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi/
        ftp://ftp.1000geno  mes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr12.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz/
        ftp://ftp.1000genomes.ebi.ac.uk /vol1/ftp/release/20130502/ALL.chr12.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi/
        ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/rele   ase/20130502/ALL.chr13.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz/
        ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr13 .phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi/
        ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr14.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz/
        ftp://  ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr14.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi/
        ftp://ftp.1 000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr15.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz/
        ftp://ftp.1000genomes.  ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr15.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi/
        ftp://ftp.1000genomes.ebi.ac.uk/v   ol1/ftp/release/20130502/ALL.chr16.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz/
        ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20 130502/ALL.chr16.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi/
        ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr17.pha se3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz/
        ftp://f tp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr17.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi/
        ftp://ftp.100   0genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr18.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz/
        ftp://ftp.1000genomes.ebi   .ac.uk/vol1/ftp/release/20130502/ALL.chr18.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi/
        ftp://ftp.1000genomes.ebi.ac.uk/vol1/   ftp/release/20130502/ALL.chr19.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz/
        ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502   /ALL.chr19.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi/
        ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr2.phase3_shape it2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz/
        ftp://ftp.1000ge    nomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr2.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi/
        ftp://ftp.1000genomes.ebi.  ac.uk/vol1/ftp/release/20130502/ALL.chr20.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz/
        ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/r  elease/20130502/ALL.chr20.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi/
        ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/A LL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz/
        ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr21.phase3_shapeit2_mv  ncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi/
        ftp://ftp.1000geno  mes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz/
        ftp://ftp.1000genomes.ebi.ac.uk /vol1/ftp/release/20130502/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi/
        ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/rele   ase/20130502/ALL.chr3.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz/
        ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr3.p    hase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi/
        f   tp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr4.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz/
        ftp://ftp.  1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr4.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi/
        ftp://ftp.1000geno  mes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr5.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz/
        ftp://ftp.1000genomes.ebi.ac.uk/    vol1/ftp/release/20130502/ALL.chr5.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi/
        ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/releas e/20130502/ALL.chr6.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz/
        ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr6.phas e3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi/
        ftp:    //ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr7.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz/
        ftp://ftp.1000  genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr7.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi/
        ftp://ftp.1000genomes.e bi.ac.uk/vol1/ftp/release/20130502/ALL.chr8.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz/
        ftp://ftp.1000genomes.ebi.ac.uk/vol1/ft p/release/20130502/ALL.chr8.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi/
        ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/2013050    2/ALL.chr9.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz/
        ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr9.phase3_shapeit2_ mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi/
        ftp://ftp.1000ge    nomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chrX.phase3_shapeit2_mvncall_integrated_v1c.20130502.genotypes.vcf.gz/
        ftp://ftp.1000genomes.ebi.ac.u  k/vol1/ftp/release/20130502/ALL.chrX.phase3_shapeit2_mvncall_integrated_v1c.20130502.genotypes.vcf.gz.tbi
do
    ((i=i%N)); ((i++==0)) && wait

  $file
done
)
