use strict;
use v5.10; # for say() function
use Cwd qw(abs_path);
use Data::Dumper;
use Parallel::ForkManager;
my $abs_path  = abs_path;
my $fastqpath = "$abs_path/../DATA/1000G/FASTQ";
my $idx       = "$abs_path/../DATA/FASTA/hg19/hg19.fa";
my $samdir    = "$abs_path/../DATA/1000G/SAM";

# rsync -avzP rsync://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/ .
# cat chr1.fa chr2.fa ... chrX.fa chrY.fa > hg19.fa
# bwa index -a bwtsw hg19.fa
# bwa mem hg19.fa R1.fastq.gz R2.fastq.gz > mySample.sam

opendir my $dir,$fastqpath or die "Cannot open directory: $!";
my @files = grep {/\.fastq.gz$/} readdir $dir;
close $dir;

my $FASTQs;

map {
    my $filename = $_;
    my ($sample,$read); 
    if ($filename =~ /(\S+)_[12]\.filt\.fastq\.gz$/) {
        ($sample) = ($1);
        $FASTQs->{$sample}++;
        warn $sample;
    }
    

} @files;

my $i;
#SRR360346_2.filt.fastq.gz
my $forks =4;
my $pm = Parallel::ForkManager->new($forks);
foreach my $sample (sort keys %$FASTQs) {
	my $pid = $pm->start and next;
     my $R1  = $sample."_1.filt.fastq.gz";
     my $R2  = $sample."_2.filt.fastq.gz";
     my $Sam = $sample.'.sam';
    `bwa mem -t 32 $idx $fastqpath/$R1 $fastqpath/$R2 > $samdir/$Sam`;
	$pm->finish;
}
$pm->wait_all_children; 
say scalar @files . "\tfastq files";
