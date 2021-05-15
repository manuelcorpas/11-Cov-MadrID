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
