use strict;
use v5.10; # for say() function
use Cwd qw(abs_path);
use Data::Dumper;

my $abs_path  = abs_path;
my $indirpath = "$abs_path/../DATA/FASTQ";

opendir my $dir,$indirpath or die "Cannot open directory: $!";
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
            foreach my $read (sort keys %{$FASTQs->{$flowcell}{$lane}{$index}}) {
                say ++$i."\t".$flowcell.'_'.$lane.'_'.$index.'_'.$read;
            }
        }
    }
}
say scalar @files . "\tfastq files";
