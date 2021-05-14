use strict;
use v5.10; # for say() function
use Cwd qw(abs_path);
use Data::Dumper;
use Spreadsheet::XLSX;

my $abs_path  = abs_path;
my $indirname = "$abs_path/INPUT/XLS";
my $infile    = 'EASI_62forParsing.xlsx';

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
map {
  my $sample_name = $_;
  
  print ++$j."\t";
  print join "\t",@{$sample->{$sample_name}};
  print "\n";

} sort keys %$sample;
