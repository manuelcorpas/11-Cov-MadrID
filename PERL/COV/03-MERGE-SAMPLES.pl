use strict;
use v5.10; # for say() function
use Cwd qw(abs_path);
use Data::Dumper;
use Spreadsheet::XLSX;
use Parallel::ForkManager;

my $abs_path  = abs_path;
my $indirname = "$abs_path/INPUT/XLS";
my $infile    = 'EASI_62forParsing.xlsx';
my $out_dir   = '/home/ec2-user/fs1/DATA/BAM.smpl';
my $in_bams   = '/home/ec2-user/fs1/DATA/BAM';

open my $fh, '<', "$indirname/$infile" or die "can't read open '$infile': $!";


my ($data,@headings);
my $i =0;
my $excel = Spreadsheet::XLSX->new("$indirname/$infile") or die "can't read open '$infile': $!";

my $worksheet = $excel->{Worksheet}[0];
$worksheet->{MaxRow} ||= $worksheet->{MinRow};


foreach my $row ($worksheet->{MinRow} .. $worksheet->{MaxRow}) {
  $worksheet->{MaxCol} ||= $worksheet->{MinCol};
  my ($MaxCol,$MinCol) = ($worksheet->{MaxCol},$worksheet->{MinCol});


  foreach my $col ($worksheet->{MinCol} ..  $worksheet->{MaxCol}) {
    if ($i == 0) {
      $headings[$col] = $worksheet->{Cells}[$row][$col]->{Val};
      next;                                                
                                    
     }
     my $cell = $worksheet->{Cells}[$row][$col];

     $data->[$row-1]{$headings[$col]} = $cell->{Val};
     #printf("( %s , %s    ) => %s\n", $row, $col, $cell->{Val}) if $cell;                                            
                          
   }
   $i++;

}

my $sample;
foreach my $row (@$data) {
  next if !$row;
  my $sample_name = $row->{'SAMPLE BARCODE'};
  my $fastq       = $row->{'NAME'};
  push @{$sample->{$sample_name}},$fastq;
}

my $j;
my $forks =8;
my $pm    = Parallel::ForkManager->new($forks);

foreach my $sample_name (sort keys %$sample) {

  $j++;
  my $pid = $pm->start and next;
    print $j."\t";
    my @bams  = @{$sample->{$sample_name}};
    my $input;
    map { $input .= "INPUT=$in_bams/$_.sorted.bam\t" } @bams;
   
    #print "$input\n";
    my $cmmd = qq(
      java -jar /mnt/efs/fs1/SOFTWARE/picard.jar MergeSamFiles ASSUME_SORTED=false CREATE_INDEX=true  $input MERGE_SEQUENCE_DICTIONARIES=false OUTPUT=$out_dir/$sample_name.merged.bam SORT_ORDER=coordinate USE_THREADING=true VALIDATION_STRINGENCY=STRICT
    );
    `$cmmd`;
    print $cmmd;
  $pm->finish;

} 
$pm->wait_all_children;

exit 1;

__END__
