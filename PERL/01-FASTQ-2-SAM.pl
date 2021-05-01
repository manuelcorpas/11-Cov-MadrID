use strict;
use v5.10; # for say() function
use Cwd qw(abs_path);
use Data::Dumper;

my $abs_path  = abs_path;
my $fastqpath = "$abs_path/../DATA/FASTQ";
my $idx       = "$abs_path/../DATA/FASTA/hg19/hg19.fa";
my $samdir    = "$abs_path/../DATA/SAM";

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
    my ($flowcell,$lane,$index,$read); 
    if ($filename =~ /(\S+)_(\S+)_(\S+)_(\S+)\.fastq.gz$/) {
        ($flowcell,$lane,$index,$read) = ($1,$2,$3,$4);
    }
    $FASTQs->{$flowcell}{$lane}{$index}{$read}++;

} @files;

my $i;
foreach my $flowcell (sort keys %$FASTQs) {
    foreach my $lane (sort keys %{$FASTQs->{$flowcell}}) {
        foreach my $index (sort keys %{$FASTQs->{$flowcell}{$lane}}){
            #foreach my $read (sort keys %{$FASTQs->{$flowcell}{$lane}{$index}}) {
            my $R1  = $flowcell.'_'.$lane.'_'.$index."_1.fastq.gz";
            my $R2  = $flowcell.'_'.$lane.'_'.$index."_2.fastq.gz";
            my $Sam = $flowcell.'_'.$lane.'_'.$index.'.sam';
            `bwa mem $idx $fastqpath/$R1 $fastqpath/$R2 > $samdir/$Sam`;
            #}
        }
    }
}
say scalar @files . "\tfastq files";
