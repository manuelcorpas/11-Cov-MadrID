use strict;
use v5.10; # for say() function
use Cwd qw(abs_path);
use Data::Dumper;
use Spreadsheet::XLSX;
use Parallel::ForkManager;
use File::Basename;

my $abs_path  = abs_path;
my $in_bams   = '/home/ec2-user/fs1/DATA/BAM.smpl';
my $tmp_dir   = '/home/ec2-user/fs1/DATA/tmp';

opendir my $dir,$in_bams or die "Cannot open directory: $!";
my @files = grep {/\.merged.bam$/} readdir $dir;
close $dir;


my $j;
my $forks = 4;
my $pm = Parallel::ForkManager->new($forks); 

foreach my $bam_file (@files) {

  $j++;
  my $pid = $pm->start and next;
    print $j."\t";
    my $input  = "$in_bams/$bam_file";
    my ($filename,$dir,$ext) = fileparse($input,'\..*'); 
    #print "$input\n";
    my $cmmd = qq(
      java -jar /mnt/efs/fs1/SOFTWARE/picard.jar MarkDuplicates CREATE_INDEX=true INPUT=$input VALIDATION_STRINGENCY=STRICT O=$in_bams/$filename.marked_duplicates.bam M=$in_bams/$filename.marked_dup_metrics.txt TMP_DIR=$tmp_dir
     );
    `$cmmd`;
    print $cmmd;
  $pm->finish;

} 
$pm->wait_all_children;

exit 1;

__END__
